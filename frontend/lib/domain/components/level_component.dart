import 'dart:async';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  final List<Connection> connections = [];
  final List<AgentComponent> agentComponents = [];

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
        nodes: nodes,
        connections: connections,
      );
      await add(agentComponent);
      agentComponents.add(agentComponent);
    }

    GameComponentRef.instance.camera.follow(agentComponents[0]);

    return super.onLoad();
  }
}
