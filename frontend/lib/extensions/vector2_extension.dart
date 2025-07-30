import 'dart:math';
import 'package:flame/game.dart';

extension Vector2Extension on Vector2 {
  double angle(Vector2 other) {
    final Vector2 diff = other - this;
    
    return atan2(diff.y, diff.x);
  }
}
