import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/types/rotating_direction.dart';
import 'package:commandos/domain/types/rotating_part.dart';
import 'package:flame/game.dart';

class RotatingBehavior extends Behavior {
  double angle = 0;
  RotatingDirection direction; // 1: clockwise, -1: counter-clockwise
  final RotatingPart rotatingPart;
  final double startAngle;
  final double rotationSpeed;
  final double? minAngle;
  final double? maxAngle;

  RotatingBehavior({
    required this.rotatingPart,
    required this.startAngle,
    required this.rotationSpeed,
    required this.direction,
    required this.minAngle,
    required this.maxAngle,
  });

  @override
  void update(EnemyComponent enemy, double dt) {
    angle += dt * rotationSpeed * direction.value;

    if (minAngle != null && maxAngle != null) {
      if (angle < minAngle!) {
        angle = minAngle!;
        direction = RotatingDirection.clockwise;
      } else if (angle > maxAngle!) {
        angle = maxAngle!;
        direction = RotatingDirection.counter_clockwise;
      }
    }

    _setAngle(enemy, angle);
  }

  @override
  void reset(EnemyComponent enemy) {
    angle = startAngle;
    _setAngle(enemy, angle);
  }

  void _setAngle(EnemyComponent enemy, double angle) {
    switch (rotatingPart) {
      case RotatingPart.head:
        enemy.headAngle = radians(angle);
        break;
      case RotatingPart.body:
        enemy.bodyAngle = radians(angle);
        break;
    }
  }
}
