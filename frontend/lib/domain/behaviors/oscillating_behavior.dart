import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/extensions/body_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class OscillatingBehavior extends Behavior {
  final double startX;
  final double startY;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final double? speedX;
  final double? speedY;

  double currentDirectionX = 1;
  double currentDirectionY = 1;
  final Vector2 velocity = Vector2(0, 0);

  OscillatingBehavior({
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
    final Vector2 position = enemy.body.position;

    if (isMinX(position.x) || isMaxX(position.x)) {
      currentDirectionX *= -1;
    }

    if (isMinY(position.y) || isMaxY(position.y)) {
      currentDirectionY *= -1;
    }

    if (isMinX(position.x)) {
      enemy.body.setPosition(Vector2(minX!, position.y));
    }

    if (isMaxX(position.x)) {
      enemy.body.setPosition(Vector2(maxX!, position.y));
    }

    if (isMinY(position.y)) {
      enemy.body.setPosition(Vector2(position.x, minY!));
    }

    if (isMaxY(position.y)) {
      enemy.body.setPosition(Vector2(position.x, maxY!));
    }

    double velocityX = 0;
    double velocityY = 0;

    if (speedX != null) {
      velocityX = speedX! * currentDirectionX;
    }

    if (speedY != null) {
      velocityY = speedY! * currentDirectionY;
    }

    velocity.setValues(velocityX, velocityY);
    enemy.body.linearVelocity.setValues(velocity.x, velocity.y);
  }

  bool isMinX(double x) => (minX != null) && (x < minX!);

  bool isMinY(double y) => (minY != null) && (y < minY!);

  bool isMaxX(double x) => (maxX != null) && (x > maxX!);

  bool isMaxY(double y) => (maxY != null) && (y > maxY!);

  @override
  void reset(EnemyComponent enemy) {
    currentDirectionX = 1;
    currentDirectionY = 1;
    velocity.setValues(0, 0);

    enemy.body.setTransform(Vector2(startX, startY), enemy.body.angle);
    enemy.body.linearVelocity.setValues(velocity.x, velocity.y);
  }
}
