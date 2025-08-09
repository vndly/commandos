import 'dart:async';
import 'package:commandos/app/constants.dart';
import 'package:commandos/app/debug.dart';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/backpack_component.dart';
import 'package:commandos/domain/components/item_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/components/soldier_component.dart';
import 'package:commandos/domain/components/turret_component.dart';
import 'package:commandos/domain/loaders/level_loader.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class LevelComponent extends Forge2DWorld with KeyboardHandler {
  final Input input = Input();
  final List<AgentComponent> agentComponents = [];
  late AgentComponent activeAgentComponent;
  late final BackpackComponent backpackComponent;
  int activeAgentIndex = 0;

  LevelComponent() {
    LevelComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() async {
    final Level level = LevelLoader.load(LevelGym.JSON);

    await add(
      MapComponent(
        walls: level.walls,
        doors: level.doors,
        size: Vector2(
          level.width.toDouble(),
          level.height.toDouble(),
        ),
      ),
    );

    for (final Agent agent in level.agents) {
      final AgentComponent agentComponent = AgentComponent(
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
          turret: turret,
        ),
      );
    }

    for (final Soldier soldier in level.soldiers) {
      await add(
        SoldierComponent(
          soldier: soldier,
          agents: agentComponents,
        ),
      );
    }

    for (final Item item in level.items) {
      await add(
        ItemComponent(item: item),
      );
    }

    backpackComponent = BackpackComponent(
      position: Vector2(5, Constants.UI_HEIGHT - 15),
    );
    await camera.viewport.add(backpackComponent);

    _switchToAgent(activeAgentIndex);

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
    activeAgentComponent.active = false;

    final int newIndex = (activeAgentIndex + shift) % agentComponents.length;
    _switchToAgent(newIndex);
  }

  void _switchToAgent(int index) {
    activeAgentIndex = index;
    activeAgentComponent = agentComponents[activeAgentIndex];
    activeAgentComponent.active = true;
    camera.follow(activeAgentComponent);
    backpackComponent.setBackpack(activeAgentComponent.agent.backpack);
  }
}

mixin LevelComponentRef {
  static late LevelComponent instance;

  LevelComponent get game => instance;
}
