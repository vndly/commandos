import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/types/rotation_direction.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class RotatingBehavior extends Behavior {
  double angle = 0;
  RotationDirection direction; // 1: clockwise, -1: counter-clockwise
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
  void update(Body body, double dt) {
    angle += dt * rotationSpeed * direction.value;

    if (minAngle != null && maxAngle != null) {
      if (angle < minAngle!) {
        angle = minAngle!;
        direction = RotationDirection.clockwise;
      } else if (angle > maxAngle!) {
        angle = maxAngle!;
        direction = RotationDirection.counter_clockwise;
      }
    }

    body.setTransform(body.position, -radians(angle));
  }

  @override
  void reset(Body body) {
    angle = startAngle;
    body.setTransform(body.position, -radians(angle));
  }
}
