import 'dart:convert';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/behaviors/harmonic_behavior.dart';
import 'package:commandos/domain/behaviors/intermittent_behavior.dart';
import 'package:commandos/domain/behaviors/moving_behavior.dart';
import 'package:commandos/domain/behaviors/orbiting_behavior.dart';
import 'package:commandos/domain/behaviors/oscillating_behavior.dart';
import 'package:commandos/domain/behaviors/rotating_behavior.dart';
import 'package:commandos/domain/json/json_agent.dart';
import 'package:commandos/domain/json/json_behavior.dart';
import 'package:commandos/domain/json/json_door.dart';
import 'package:commandos/domain/json/json_item.dart';
import 'package:commandos/domain/json/json_laser.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/json/json_path.dart';
import 'package:commandos/domain/json/json_polygon.dart';
import 'package:commandos/domain/json/json_position.dart';
import 'package:commandos/domain/json/json_soldier.dart';
import 'package:commandos/domain/json/json_turret.dart';
import 'package:commandos/domain/json/json_wall.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/backpack.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/portal.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/domain/types/behavior_type.dart';
import 'package:flame/components.dart';

class LevelLoader {
  static Level load(String json) {
    final JsonLevel jsonLevel = JsonLevel.fromJson(jsonDecode(json));
    final List<Door> doors = _getDoors(jsonLevel.doors);
    final Nodes nodes = _getNodes(
      jsonLevel: jsonLevel,
      doors: doors,
    );

    return Level(
      id: jsonLevel.id,
      width: jsonLevel.width,
      height: jsonLevel.height,
      nodes: nodes,
      portals: _getPortals(
        portals: jsonLevel.portals,
        nodes: nodes,
      ),
      agents: _getAgents(
        agents: jsonLevel.agents,
        nodes: nodes,
      ),
      turrets: _getTurrets(
        jsonLevel.turrets,
      ),
      soldiers: _getSoldiers(
        jsonLevel.soldiers,
      ),
      walls: _getWalls(
        jsonLevel.walls,
      ),
      doors: doors,
      items: _getItems(
        jsonLevel.items,
      ),
    );
  }

  static Nodes _getNodes({
    required JsonLevel jsonLevel,
    required List<Door> doors,
  }) {
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

      for (final Door door in doors) {
        nodeA.addObject(object: door, position: door.position);
        nodeB.addObject(object: door, position: door.position);
      }
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

  static List<Portal> _getPortals({
    required List<JsonPath> portals,
    required Nodes nodes,
  }) {
    final List<Portal> result = [];

    for (final JsonPath path in portals) {
      final Node nodeA = nodes.nodeAt(_toVector2(path.a));
      final Node nodeB = nodes.nodeAt(_toVector2(path.b));

      result.add(Portal(a: nodeA, b: nodeB));
    }

    return result;
  }

  static List<Agent> _getAgents({
    required List<JsonAgent> agents,
    required Nodes nodes,
  }) {
    final List<Agent> result = [];

    for (final JsonAgent agent in agents) {
      result.add(
        Agent(
          id: agent.id,
          position: _toVector2(agent.position),
          backpack: Backpack(items: {}),
        ),
      );
    }

    return result;
  }

  static List<Turret> _getTurrets(List<JsonTurret> turrets) {
    final List<Turret> result = [];

    for (final JsonTurret turret in turrets) {
      result.add(
        Turret(
          id: turret.id,
          position: _toVector2(turret.position),
          angle: radians(turret.angle),
          lasers: turret.lasers.map(_getLaser).toList(),
          behaviors: turret.behaviors.map(_getBehavior).toList(),
        ),
      );
    }

    return result;
  }

  static List<Soldier> _getSoldiers(List<JsonSoldier> soldiers) {
    final List<Soldier> result = [];

    for (final JsonSoldier soldier in soldiers) {
      result.add(
        Soldier(
          id: soldier.id,
          position: _toVector2(soldier.position),
          angle: radians(soldier.angle),
          sweep: radians(soldier.sweep),
          range: soldier.range,
          behaviors: soldier.behaviors.map(_getBehavior).toList(),
        ),
      );
    }

    return result;
  }

  static Laser _getLaser(JsonLaser jsonLaser) => Laser(
    angle: radians(jsonLaser.angle),
    range: jsonLaser.range,
  );

  static List<Wall> _getWalls(List<JsonWall> walls) {
    final List<Wall> result = [];

    for (final JsonWall wall in walls) {
      final List<Vector2> points = _getPolygon(wall.polygon);
      result.add(Wall(points: points));
    }

    return result;
  }

  static List<Door> _getDoors(List<JsonDoor> doors) {
    final List<Door> result = [];

    for (final JsonDoor door in doors) {
      final List<Vector2> points = _getPolygon(door.polygon);
      result.add(
        Door(
          points: points,
          status: door.status,
        ),
      );
    }

    return result;
  }

  static List<Item> _getItems(List<JsonItem> items) {
    final List<Item> result = [];

    for (final JsonItem item in items) {
      result.add(
        Item(
          type: item.type,
          position: _toVector2(item.position),
        ),
      );
    }

    return result;
  }

  /*static List<Portal> _getPortals(List<JsonPortal> portals) {
    final List<Portal> result = [];

    for (final JsonPortal portal in portals) {
      final Portal entrance = Portal(
        id: 'a',
        group: portal.id.substring(0, portal.id.length - 1),
        polygon: Polygon(points: _getPolygon(portal.entrance)),
      );
      final Portal exit = Portal(
        id: 'b',
        group: portal.id.substring(0, portal.id.length - 1),
        polygon: Polygon(points: _getPolygon(portal.exit)),
      );

      entrance.destination = exit;
      exit.destination = entrance;

      result.add(entrance);
      result.add(exit);
    }

    return result;
  }*/

  static Behavior _getBehavior(JsonBehavior jsonBehavior) {
    switch (jsonBehavior.type) {
      case BehaviorType.rotating:
        return RotatingBehavior(
          startAngle: jsonBehavior.startAngle!,
          rotationSpeed: jsonBehavior.speed!,
          direction: jsonBehavior.rotatingDirection!,
          minAngle: jsonBehavior.minAngle,
          maxAngle: jsonBehavior.maxAngle,
        );

      case BehaviorType.orbiting:
        return OrbitingBehavior(
          startAngle: jsonBehavior.startAngle!,
          centerX: jsonBehavior.centerX!,
          centerY: jsonBehavior.centerY!,
          radius: jsonBehavior.radius!,
          angularSpeed: jsonBehavior.speed!,
        );

      case BehaviorType.oscillating:
        return OscillatingBehavior(
          startX: jsonBehavior.startX!,
          startY: jsonBehavior.startY!,
          minX: jsonBehavior.minX,
          maxX: jsonBehavior.maxX,
          minY: jsonBehavior.minY,
          maxY: jsonBehavior.maxY,
          speedX: jsonBehavior.speedX,
          speedY: jsonBehavior.speedY,
        );

      case BehaviorType.moving:
        return MovingBehavior(
          trigger: jsonBehavior.trigger!,
          startX: jsonBehavior.startX!,
          startY: jsonBehavior.startY!,
          minX: jsonBehavior.minX,
          maxX: jsonBehavior.maxX,
          minY: jsonBehavior.minY,
          maxY: jsonBehavior.maxY,
          speedX: jsonBehavior.speedX,
          speedY: jsonBehavior.speedY,
        );

      case BehaviorType.harmonic:
        return HarmonicBehavior(
          startX: jsonBehavior.startX!,
          startY: jsonBehavior.startY!,
          periodX: jsonBehavior.periodX,
          periodY: jsonBehavior.periodY,
          amplitudeX: jsonBehavior.amplitudeX,
          amplitudeY: jsonBehavior.amplitudeY,
          initialTime: jsonBehavior.initialTime,
        );

      case BehaviorType.intermittent:
        return IntermittentBehavior(
          timeOn: jsonBehavior.timeOn!,
          timeOff: jsonBehavior.timeOff!,
          intermittentState: jsonBehavior.intermittentState!,
          initialTime: jsonBehavior.initialTime,
        );
    }
  }

  static List<Vector2> _getPolygon(JsonPolygon jsonPolygon) =>
      jsonPolygon.vertices.map(_toVector2).toList();

  static Vector2 _toVector2(JsonPosition position) =>
      Vector2(position.x.toDouble(), position.y.toDouble());
}
