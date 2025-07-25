import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class MovingBehavior extends Behavior {
  bool started = false;
  final double trigger;
  final double startX;
  final double startY;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final double? speedX;
  final double? speedY;

  MovingBehavior({
    required this.trigger,
    required this.startX,
    required this.startY,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.speedX,
    required this.speedY,
  });

  @override
  void update(Body body, double dt) {
    if (!started) {
      started = true;
      body.linearVelocity = Vector2(speedX ?? 0, speedY ?? 0);
    }

    if (started) {
      final Vector2 position = body.position;
      final double angle = body.angle;

      if ((minX != null) && (position.x < minX!)) {
        body.setTransform(Vector2(minX!, position.y), angle);
        body.linearVelocity.setValues(0, body.linearVelocity.y);
      }

      if ((maxX != null) && (position.x > maxX!)) {
        body.setTransform(Vector2(maxX!, position.y), angle);
        body.linearVelocity.setValues(0, body.linearVelocity.y);
      }

      if ((minY != null) && (position.y < minY!)) {
        body.setTransform(Vector2(position.x, minY!), angle);
        body.linearVelocity.setValues(body.linearVelocity.x, 0);
      }

      if ((maxY != null) && (position.y > maxY!)) {
        body.setTransform(Vector2(position.x, maxY!), angle);
        body.linearVelocity.setValues(body.linearVelocity.x, 0);
      }
    }
  }

  @override
  void reset(Body body) {
    started = false;

    body.setTransform(Vector2(startX, startY), body.angle);
    body.linearVelocity.setValues(0, 0);
  }
}
