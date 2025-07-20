import 'dart:convert';
import 'package:commandos/domain/json/json_agent.dart';
import 'package:commandos/domain/json/json_laser.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/json/json_path.dart';
import 'package:commandos/domain/json/json_position.dart';
import 'package:commandos/domain/json/json_turret.dart';
import 'package:commandos/domain/json/json_wall.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:flame/components.dart';

class LevelLoader {
  static Level load(String json) {
    final JsonLevel jsonLevel = JsonLevel.fromJson(jsonDecode(json));
    final Nodes nodes = _getNodes(jsonLevel);

    return Level(
      id: jsonLevel.id,
      width: jsonLevel.width,
      height: jsonLevel.height,
      nodes: nodes,
      agents: _getAgents(
        agents: jsonLevel.agents,
        nodes: nodes,
      ),
      turrets: _getTurrets(
        turrets: jsonLevel.turrets,
        nodes: nodes,
      ),
      connections: _getConnections(
        connections: jsonLevel.connections,
        nodes: nodes,
      ),
      walls: _getWalls(
        walls: jsonLevel.walls,
        nodes: nodes,
      ),
    );
  }

  static Nodes _getNodes(JsonLevel jsonLevel) {
    final Map<String, Node> result = {};

    for (final JsonPath path in jsonLevel.paths) {
      final Node nodeA = _addNode(
        result: result,
        position: _toVector2(path.a),
      );
      final Node nodeB = _addNode(
        result: result,
        position: _toVector2(path.b),
      );

      nodeA.addConnection(nodeB);
      nodeB.addConnection(nodeA);
    }

    return Nodes(nodes: result.values.toList());
  }

  static Node _addNode({
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

  static List<Agent> _getAgents({
    required List<JsonAgent> agents,
    required Nodes nodes,
  }) {
    final List<Agent> result = [];

    for (final JsonAgent agent in agents) {
      final Node node = nodes.nodeAt(_toVector2(agent.position));
      result.add(Agent(id: agent.id, position: node.position));
    }

    return result;
  }

  static List<Turret> _getTurrets({
    required List<JsonTurret> turrets,
    required Nodes nodes,
  }) {
    final List<Turret> result = [];

    for (final JsonTurret turret in turrets) {
      final Node node = nodes.nodeAt(_toVector2(turret.position));
      result.add(
        Turret(
          id: turret.id,
          position: node.position,
          angle: radians(turret.angle),
          lasers: turret.lasers.map(_getLaser).toList(),
        ),
      );
    }

    return result;
  }

  static Laser _getLaser(JsonLaser jsonLaser) => Laser(
    angle: radians(jsonLaser.angle),
    length: jsonLaser.length,
  );

  static List<Connection> _getConnections({
    required List<JsonPath> connections,
    required Nodes nodes,
  }) {
    final List<Connection> result = [];

    for (final JsonPath path in connections) {
      final Node nodeA = nodes.nodeAt(_toVector2(path.a));
      final Node nodeB = nodes.nodeAt(_toVector2(path.b));

      result.add(Connection(a: nodeA, b: nodeB));
    }

    return result;
  }

  static List<Wall> _getWalls({
    required List<JsonWall> walls,
    required Nodes nodes,
  }) {
    final List<Wall> result = [];

    for (final JsonWall wall in walls) {
      final List<Vector2> vertices = wall.vertices.map(_toVector2).toList();
      result.add(Wall(vertices: vertices));
    }

    return result;
  }

  static Vector2 _toVector2(JsonPosition position) =>
      Vector2(position.x.toDouble(), position.y.toDouble());
}
