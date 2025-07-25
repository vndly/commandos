import 'dart:convert';
import 'package:commandos/domain/json/json_agent.dart';
import 'package:commandos/domain/json/json_laser.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/json/json_position.dart';
import 'package:commandos/domain/json/json_turret.dart';
import 'package:commandos/domain/json/json_wall.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:flame/components.dart';

class LevelLoader {
  static Level load(String json) {
    final JsonLevel jsonLevel = JsonLevel.fromJson(jsonDecode(json));

    return Level(
      id: jsonLevel.id,
      width: jsonLevel.width,
      height: jsonLevel.height,
      agents: _getAgents(
        jsonLevel.agents,
      ),
      turrets: _getTurrets(
        jsonLevel.turrets,
      ),
      walls: _getWalls(
        jsonLevel.walls,
      ),
    );
  }

  static List<Agent> _getAgents(
    List<JsonAgent> agents,
  ) {
    final List<Agent> result = [];

    for (final JsonAgent agent in agents) {
      result.add(
        Agent(
          id: agent.id,
          position: _toVector2(agent.position),
          angle: radians(agent.angle),
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
      final List<Vector2> vertices = wall.vertices.map(_toVector2).toList();
      result.add(Wall(vertices: vertices));
    }

    return result;
  }

  static Vector2 _toVector2(JsonPosition position) =>
      Vector2(position.x.toDouble(), position.y.toDouble());
}
