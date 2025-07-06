import 'dart:async';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class LevelComponent extends Forge2DWorld  with KeyboardHandler{
  final Input input = Input();
  final List<Connection> connections = [];
  final List<AgentComponent> agentComponents = [];
  late AgentComponent activeAgentComponent;

  @override
  FutureOr onLoad() async {
    final JsonLevel jsonLevel = JsonLevel.fromString(LevelGym.JSON);
    final Nodes nodes = jsonLevel.nodes;
    connections.addAll(jsonLevel.getConnections(nodes));

    await add(
      MapComponent(
        nodes: nodes,
        size: Vector2(jsonLevel.width.toDouble(), jsonLevel.height.toDouble()),
      ),
    );

    for (final Agent agent in jsonLevel.getAgents(nodes)) {
      final AgentComponent agentComponent = AgentComponent(
        initialPosition: agent.position,
        size: Vector2(6, 6),
        input: input,
        nodes: nodes,
        connections: connections,
        active: false,
      );
      await add(agentComponent);
      agentComponents.add(agentComponent);
    }

    activeAgentComponent = agentComponents[0];
    activeAgentComponent.active = true;
    GameComponentRef.instance.camera.follow(activeAgentComponent);

    return super.onLoad();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (input.onKeyEvent(event, keysPressed)) {
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }
}
