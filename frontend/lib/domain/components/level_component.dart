import 'dart:async';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  final List<Node> nodes = [];
  final List<Connection> connections = [];
  late final AgentComponent agentComponent;

  @override
  FutureOr onLoad() async {
    final JsonLevel jsonLevel = JsonLevel.fromString(LevelGym.JSON);
    nodes.addAll(jsonLevel.nodes);
    connections.addAll(jsonLevel.getConnections);

    await add(
      MapComponent(
        nodes: nodes,
        size: Vector2(jsonLevel.width.toDouble(), jsonLevel.height.toDouble()),
      ),
    );

    agentComponent = AgentComponent(
      initialPosition: Vector2(15, 85),
      size: Vector2(6, 6),
      nodes: nodes,
    );
    await add(agentComponent);

    GameComponentRef.instance.camera.follow(agentComponent);

    return super.onLoad();
  }
}
