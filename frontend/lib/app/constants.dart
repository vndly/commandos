import 'package:flame/components.dart';

class Constants {
  static const int NEON_EFFECT = 2;

  static const double PAN_THRESHOLD = 3;

  static const double CHARACTER_SPEED = 50;

  static const bool RENDER_BODIES = true;

  static const double MAP_GRID_RATIO = 10;
  static const double CHARACTER_GRID_RATIO = 25;

  static const double MAP_SIZE_WIDTH = 100;
  static const double MAP_SIZE_HEIGHT = 100;
  static final Vector2 MAP_CENTER = Vector2(
    MAP_SIZE_WIDTH / 2,
    MAP_SIZE_HEIGHT / 2,
  );
}
