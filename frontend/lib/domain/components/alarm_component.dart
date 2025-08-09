import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class AlarmComponent extends PositionComponent {
  double level = 0;
  final Paint paintBorder = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.ALARM_BORDER,
  );
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.ALARM_FILL,
  );

  AlarmComponent({
    required super.position,
  }) : super(
         size: Vector2(100, 3),
         priority: Priority.alarm.value,
       );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.x * level, size.y),
      paintFill,
    );

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.x, size.y),
      paintBorder,
    );
  }
}
