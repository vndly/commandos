import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primary = Colors.blue;
  static const Color transparent = Colors.transparent;

  static const Color GAME_BACKGROUND = Colors.black;

  static Color LASER = Colors.red.withAlpha(140);
  static Color SOLDIER = Colors.red.withAlpha(140);
  static Color TURRET = Colors.red.withAlpha(140);
  static Color VISION = Colors.yellow.withAlpha(140);
  static Color DETECTED = Colors.red.withAlpha(140);
  static Color WALL = Colors.white;
  static Color DOOR_CLOSED = Colors.red.withAlpha(140);
  static Color DOOR_OPEN = Colors.green.withAlpha(140);

  static Paint paint({
    PaintingStyle? style,
    Color? color,
    double? strokeWidth,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
  }) {
    final Paint paint = Paint();

    if (color != null) {
      paint.color = color;
    }

    if (strokeWidth != null) {
      paint.strokeWidth = strokeWidth;
    }

    if (style != null) {
      paint.style = style;
    }

    if (strokeCap != null) {
      paint.strokeCap = strokeCap;
    }

    if (strokeJoin != null) {
      paint.strokeJoin = strokeJoin;
    }

    return paint;
  }
}
