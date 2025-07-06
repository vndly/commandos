import 'dart:convert';
import 'package:commandos/domain/json/json_agent.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:flame/components.dart';
import 'package:json_annotation/json_annotation.dart';
import 'json_path.dart';

part 'json_level.g.dart';

@JsonSerializable()
class JsonLevel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'width')
  final int width;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'paths')
  final List<JsonPath> paths;

  @JsonKey(name: 'connections')
  final List<JsonPath> connections;

  @JsonKey(name: 'agents')
  final List<JsonAgent> agents;

  const JsonLevel({
    required this.id,
    required this.width,
    required this.height,
    required this.paths,
    required this.connections,
    required this.agents,
  });

  factory JsonLevel.fromString(String input) {
    final dynamic json = jsonDecode(input);

    return JsonLevel.fromJson(json);
  }

  factory JsonLevel.fromJson(Map<String, dynamic> json) =>
      _$JsonLevelFromJson(json);

  Nodes get nodes {
    final Map<String, Node> result = {};

    for (final JsonPath path in paths) {
      final Node nodeA = _addNode(
        result: result,
        position: path.a.vector2,
      );
      final Node nodeB = _addNode(
        result: result,
        position: path.b.vector2,
      );

      nodeA.addConnection(nodeB);
      nodeB.addConnection(nodeA);
    }

    return Nodes(nodes: result.values.toList());
  }

  Node _addNode({
    required Map<String, Node> result,
    required Vector2 position,
  }) {
    final String id = '${position.x.toInt()},${position.y.toInt()}';

    if (result.containsKey(id)) {
      return result[id]!;
    } else {
      final Node node = Node(position: position);
      result[id] = node;

      return node;
    }
  }

  List<Connection> getConnections(Nodes nodes) {
    final List<Connection> result = [];

    for (final JsonPath path in connections) {
      final Node nodeA = nodes.nodeAt(path.a.vector2);
      final Node nodeB = nodes.nodeAt(path.b.vector2);

      result.add(Connection(a: nodeA, b: nodeB));
    }

    return result;
  }

  List<Agent> getAgents(Nodes nodes) {
    final List<Agent> result = [];

    for (final JsonAgent agent in agents) {
      final Node node = nodes.nodeAt(agent.position.vector2);
      result.add(Agent(id: agent.id, position: node.position));
    }

    return result;
  }

  Map<String, dynamic> toJson() => _$JsonLevelToJson(this);
}
