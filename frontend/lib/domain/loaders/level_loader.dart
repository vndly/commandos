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
import 'package:commandos/domain/json/json_position.dart';
import 'package:commandos/domain/json/json_soldier.dart';
import 'package:commandos/domain/json/json_turret.dart';
import 'package:commandos/domain/json/json_wall.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/level.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/domain/types/behavior_type.dart';
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
      soldiers: _getSoldiers(
        jsonLevel.soldiers,
      ),
      walls: _getWalls(
        jsonLevel.walls,
      ),
      doors: _getDoors(
        jsonLevel.doors,
      ),
      items: _getItems(
        jsonLevel.items,
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
    sweep: jsonLaser.sweep,
    range: jsonLaser.range,
    numberOfBeams: jsonLaser.numberOfBeams,
  );

  static List<Wall> _getWalls(List<JsonWall> walls) {
    final List<Wall> result = [];

    for (final JsonWall wall in walls) {
      final List<Vector2> points = wall.vertices.map(_toVector2).toList();
      result.add(Wall(points: points));
    }

    return result;
  }

  static List<Door> _getDoors(List<JsonDoor> doors) {
    final List<Door> result = [];

    for (final JsonDoor door in doors) {
      final List<Vector2> points = door.vertices.map(_toVector2).toList();
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

  static Vector2 _toVector2(JsonPosition position) =>
      Vector2(position.x.toDouble(), position.y.toDouble());
}
