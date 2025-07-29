import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
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
  void update(EnemyComponent enemy, double dt) {
    if (!started) {
      started = true;
      enemy.body.linearVelocity = Vector2(speedX ?? 0, speedY ?? 0);
    }

    if (started) {
      final Vector2 position = enemy.body.position;
      final double angle = enemy.body.angle;

      if ((minX != null) && (position.x < minX!)) {
        enemy.body.setTransform(Vector2(minX!, position.y), angle);
        enemy.body.linearVelocity.setValues(0, enemy.body.linearVelocity.y);
      }

      if ((maxX != null) && (position.x > maxX!)) {
        enemy.body.setTransform(Vector2(maxX!, position.y), angle);
        enemy.body.linearVelocity.setValues(0, enemy.body.linearVelocity.y);
      }

      if ((minY != null) && (position.y < minY!)) {
        enemy.body.setTransform(Vector2(position.x, minY!), angle);
        enemy.body.linearVelocity.setValues(enemy.body.linearVelocity.x, 0);
      }

      if ((maxY != null) && (position.y > maxY!)) {
        enemy.body.setTransform(Vector2(position.x, maxY!), angle);
        enemy.body.linearVelocity.setValues(enemy.body.linearVelocity.x, 0);
      }
    }
  }

  @override
  void reset(EnemyComponent enemy) {
    started = false;

    enemy.body.setTransform(Vector2(startX, startY), enemy.body.angle);
    enemy.body.linearVelocity.setValues(0, 0);
  }
}
