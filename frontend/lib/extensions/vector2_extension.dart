import 'dart:math';
import 'package:flame/game.dart';

extension Vector2Extension on Vector2 {
  double angle(Vector2 other) {
    final Vector2 diff = other - this;

    return atan2(diff.y, diff.x);
  }

  double get angled => atan2(y, x);

  bool around({
    required Vector2 point,
    required double epsilon,
  }) => ((point.x - x).abs() < epsilon) && ((point.y - y).abs() < epsilon);
}
