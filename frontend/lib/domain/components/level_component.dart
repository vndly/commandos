import 'dart:async';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/components/turret_component.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/loaders/level_loader.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/turret.dart';
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
    final JsonLevel jsonLevel = JsonLevel.fromString(LevelGym.JSON);
    final Level level = LevelLoader.load(jsonLevel);
    final Nodes nodes = level.nodes;
    connections.addAll(level.connections);

    await add(
      MapComponent(
        nodes: nodes,
        size: Vector2(jsonLevel.width.toDouble(), jsonLevel.height.toDouble()),
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

    activeAgentComponent = agentComponents[activeAgentIndex];
    activeAgentComponent.active = true;
    GameComponentRef.instance.camera.follow(activeAgentComponent);

    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (input.onKeyEvent(event, keysPressed)) {
      if ((event is KeyDownEvent) &&
          keysPressed.contains(LogicalKeyboardKey.tab)) {
        _switchAgent();
      }

      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }

  void _switchAgent() {
    activeAgentIndex = (activeAgentIndex + 1) % agentComponents.length;
    activeAgentComponent.active = false;
    activeAgentComponent = agentComponents[activeAgentIndex];
    activeAgentComponent.active = true;
    GameComponentRef.instance.camera.follow(activeAgentComponent);
  }
}
