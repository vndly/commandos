import 'dart:async';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/components/turret_component.dart';
import 'package:commandos/domain/components/wall_component.dart';
import 'package:commandos/domain/loaders/level_loader.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class LevelComponent extends Forge2DWorld with KeyboardHandler {
  final Input input = Input();
  final List<Connection> connections = [];
  final List<AgentComponent> agentComponents = [];
  late AgentComponent activeAgentComponent;
  int activeAgentIndex = 0;

  @override
  FutureOr onLoad() async {
    final Level level = LevelLoader.load(LevelGym.JSON);
    final Nodes nodes = level.nodes;
    connections.addAll(level.connections);

    await add(
      MapComponent(
        nodes: nodes,
        size: Vector2(level.width.toDouble(), level.height.toDouble()),
      ),
    );

    for (final Agent agent in level.agents) {
      final AgentComponent agentComponent = AgentComponent(
        initialPosition: agent.position,
        size: Vector2(6, 6),
        input: input,
        agent: agent,
        nodes: nodes,
        connections: connections,
        active: false,
      );
      await add(agentComponent);
      agentComponents.add(agentComponent);
    }

    for (final Turret turret in level.turrets) {
      await add(
        TurretComponent(
          initialPosition: turret.position,
          size: Vector2(6, 6),
          turret: turret,
        ),
      );
    }

    for (final Wall wall in level.walls) {
      await add(
        WallComponent(wall: wall),
      );
    }

    activeAgentComponent = agentComponents[activeAgentIndex];
    activeAgentComponent.active = true;
    GameComponentRef.instance.camera.follow(activeAgentComponent);

    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    input.onKeyEvent(event, keysPressed);

    if (input.isSwitchingAgentForward(event, keysPressed)) {
      _switchAgent();
    }

    return false;
  }

  void _switchAgent() {
    activeAgentIndex = (activeAgentIndex + 1) % agentComponents.length;
    activeAgentComponent.active = false;
    activeAgentComponent = agentComponents[activeAgentIndex];
    activeAgentComponent.active = true;
    GameComponentRef.instance.camera.follow(activeAgentComponent);
  }
}
