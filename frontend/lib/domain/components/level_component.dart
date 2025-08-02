import 'dart:async';
import 'package:commandos/app/debug.dart';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/door_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/components/soldier_component.dart';
import 'package:commandos/domain/components/turret_component.dart';
import 'package:commandos/domain/components/wall_component.dart';
import 'package:commandos/domain/loaders/level_loader.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class LevelComponent extends Forge2DWorld with KeyboardHandler {
  final Input input = Input();
  final List<AgentComponent> agentComponents = [];
  late AgentComponent activeAgentComponent;
  int activeAgentIndex = 0;

  LevelComponent() {
    LevelComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() async {
    final Level level = LevelLoader.load(LevelGym.JSON);

    await add(
      MapComponent(
        path0: Assets.IMAGES_LEVELS_GYM0,
        path1: Assets.IMAGES_LEVELS_GYM1,
        path2: Assets.IMAGES_LEVELS_GYM2,
        size: Vector2(level.width.toDouble(), level.height.toDouble()),
      ),
    );

    for (final Agent agent in level.agents) {
      final AgentComponent agentComponent = AgentComponent(
        initialPosition: agent.position,
        input: input,
        agent: agent,
        active: false,
      );
      await add(agentComponent);
      agentComponents.add(agentComponent);
    }

    for (final Turret turret in level.turrets) {
      await add(
        TurretComponent(
          initialPosition: turret.position,
          size: Vector2(4, 4),
          turret: turret,
        ),
      );
    }

    for (final Soldier soldier in level.soldiers) {
      await add(
        SoldierComponent(
          initialPosition: soldier.position,
          soldier: soldier,
          agents: agentComponents,
        ),
      );
    }

    for (final Wall wall in level.walls) {
      await add(
        WallComponent(wall: wall),
      );
    }

    await add(
      DoorComponent(
        pathTop: Assets.IMAGES_DOORS_DOOR_TOP,
        pathBottom: Assets.IMAGES_DOORS_DOOR_BOTTOM,
        position: Vector2(50, 150),
        size: Vector2(20, 20),
      ),
    );

    /*await add(
      LightComponent(
        path: Assets.IMAGES_LIGHT_LIGHT,
        position: Vector2(100, 5),
        size: Vector2(40, 40),
      ),
    );*/

    activeAgentComponent = agentComponents[activeAgentIndex];
    activeAgentComponent.active = true;
    GameComponentRef.instance.camera.follow(activeAgentComponent);

    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    input.onKeyEvent(event, keysPressed);

    if (input.isSwitchingAgentForward(event, keysPressed)) {
      _switchAgent(1);
    } else if (input.isSwitchingAgentBackward(event, keysPressed)) {
      _switchAgent(-1);
    } else if (input.isDebugOff(event, keysPressed)) {
      Debug.set(DebugMode.off);
    } else if (input.isDebugMode1(event, keysPressed)) {
      Debug.set(DebugMode.mode1);
    } else if (input.isDebugMode2(event, keysPressed)) {
      Debug.set(DebugMode.mode2);
    } else if (input.isDebugMode3(event, keysPressed)) {
      Debug.set(DebugMode.mode3);
    }

    return false;
  }

  void _switchAgent(int shift) {
    activeAgentIndex = (activeAgentIndex + shift) % agentComponents.length;
    activeAgentComponent.active = false;
    activeAgentComponent = agentComponents[activeAgentIndex];
    activeAgentComponent.active = true;
    GameComponentRef.instance.camera.follow(activeAgentComponent);
  }
}

mixin LevelComponentRef {
  static late LevelComponent instance;

  LevelComponent get game => instance;
}
