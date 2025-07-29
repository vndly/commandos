import 'dart:math';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class HarmonicBehavior extends Behavior {
  final Vector2 position = Vector2(0, 0);
  double time = 0;

  final double startX;
  final double startY;
  final double? periodX;
  final double? periodY;
  final double? amplitudeX;
  final double? amplitudeY;
  final double? initialTime;

  static const double TWO_PI = pi * 2;

  HarmonicBehavior({
    required this.startX,
    required this.startY,
    required this.periodX,
    required this.periodY,
    required this.amplitudeX,
    required this.amplitudeY,
    required this.initialTime,
  });

  @override
  void update(EnemyComponent enemy, double dt) {
    time += dt;
    double x = 0;
    double y = 0;

    if ((periodX != null) && (amplitudeX != null)) {
      x = amplitudeX! * sin(TWO_PI * time / periodX!);
    }

    if ((periodY != null) && (amplitudeY != null)) {
      y = amplitudeY! * sin(TWO_PI * time / periodY!);
    }

    position.setValues(startX + x, startY - y);
    enemy.body.setTransform(position, enemy.body.angle);
  }

  @override
  void reset(EnemyComponent enemy) {
    time = initialTime ?? 0;
    position.setValues(startX, startY);
    enemy.body.setTransform(position, enemy.body.angle);
  }
}
