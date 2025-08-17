import 'dart:math';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/extensions/body_extension.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class OrbitingBehavior extends Behavior {
  double currentAngle = 0;
  final double startAngle;
  final double centerX;
  final double centerY;
  final double radius;
  final double angularSpeed;
  final Vector2 position = Vector2(0, 0);

  OrbitingBehavior({
    required this.startAngle,
    required this.centerX,
    required this.centerY,
    required this.radius,
    required this.angularSpeed,
  });

  @override
  void update(EnemyComponent enemy, double dt) {
    updateAngle(dt, angularSpeed);
    updatePosition(enemy.body, currentAngle, radius, centerX, centerY);
  }

  void updateAngle(double delta, double speed) {
    currentAngle += delta * speed;
    currentAngle = currentAngle % 360;
  }

  void updatePosition(
    Body body,
    double angle,
    double radius,
    double centerX,
    double centerY,
  ) {
    final double angleRadians = -radians(angle);
    final double x = (cos(angleRadians) * radius) + centerX;
    final double y = (sin(angleRadians) * radius) + centerY;
    position.setValues(x, y);
    body.setPosition(position);
  }

  @override
  void reset(EnemyComponent enemy) {
    currentAngle = startAngle;
    updatePosition(enemy.body, currentAngle, radius, centerX, centerY);
  }
}
