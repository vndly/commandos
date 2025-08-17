import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/types/rotating_direction.dart';
import 'package:commandos/extensions/body_extension.dart';
import 'package:flame/game.dart';

class RotatingBehavior extends Behavior {
  double angle = 0;
  RotatingDirection direction; // 1: clockwise, -1: counter-clockwise
  final double startAngle;
  final double rotationSpeed;
  final double? minAngle;
  final double? maxAngle;

  RotatingBehavior({
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

    enemy.body.setAngle(radians(angle));
  }

  @override
  void reset(EnemyComponent enemy) {
    angle = startAngle;
    enemy.body.setTransform(enemy.body.position, radians(angle));
  }
}
