import 'dart:async';
import 'package:cavedash/domain/components/unit_component.dart';
import 'package:cavedash/domain/state/game/base.dart';
import 'package:cavedash/domain/types/priority.dart';
import 'package:cavedash/extensions/canvas_extension.dart';
import 'package:cavedash/extensions/color_extension.dart';
import 'package:cavedash/extensions/component_extension.dart';
import 'package:cavedash/utils/palette.dart';
import 'package:cavedash/utils/set_fullscreen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class BaseComponent extends PositionComponent with CollisionCallbacks {
  final Base base;
  final Paint backgroundPaint = Paint();
  final Paint foregroundPaint = Paint();
  final Paint borderPaint = Paint();

  BaseComponent({
    required this.base,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.topLeft,
          priority: Priority.base.value,
        );

  @override
  FutureOr onLoad() {
    add(RectangleHitbox());

    backgroundPaint.color = Palette.BASE_BACKGROUND;
    foregroundPaint.color = base.color.darken(0.3);

    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 7;
    borderPaint.color = base.color.darken(0.1);

    if (base.owner.isEnemy) {
      add(FullScreenButtonComponent(
        position: Vector2(
          width - (height / 2),
          height / 2,
        ),
        size: Vector2(
          height * 0.7,
          height * 0.7,
        ),
      ));
    }

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) && (base.owner != other.unit.owner)) {
      engine.onUnitCollidedWithBase(
        unit: other.unit,
        base: base,
      );
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      borderPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      backgroundPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width * (base.hp / 100), height),
      foregroundPaint,
    );

    canvas.drawText(
      text: base.owner.id.toUpperCase(),
      position: size / 2,
      size: size.y / 2,
      color: Palette.BASE_PLAYER_NAME,
    );
  }
}

class FullScreenButtonComponent extends PositionComponent with TapCallbacks {
  final Paint backgroundPaint = Paint();
  final Paint foregroundPaint = Paint();

  FullScreenButtonComponent({
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.base.value,
        );

  @override
  FutureOr onLoad() {
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.color = Colors.white;

    foregroundPaint.color = Colors.white;

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) => SetFullscreen.set();

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      (size / 2).toOffset(),
      size.x / 2,
      backgroundPaint,
    );

    canvas.drawText(
      text: '⌞ ⌝',
      position: size / 2,
      size: size.y / 2,
      color: Palette.BASE_PLAYER_NAME,
    );
  }
}
