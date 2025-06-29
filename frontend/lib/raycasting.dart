import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class RaycastLightExample extends FlameGame
    with HasCollisionDetection, MouseMovementDetector {
  Vector2? origin;
  Paint paint = Paint();
  Paint tapPaint = Paint();

  final _colorTween = ColorTween(
    begin: Colors.blue.withValues(alpha: 0.2),
    end: Colors.red.withValues(alpha: 0.2),
  );

  static const numberOfRays = 2000;
  final List<Ray2> rays = [];
  final List<Ray2> tapRays = [];
  final List<RaycastResult<ShapeHitbox>> results = [];
  final List<RaycastResult<ShapeHitbox>> tapResults = [];

  late Path path;
  @override
  Future<void> onLoad() async {
    final paint = BasicPalette.gray.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    add(ScreenHitbox());
    add(
      CircleComponent(
        position: Vector2(100, 100),
        radius: 50,
        paint: paint,
        children: [CircleHitbox()],
      ),
    );
    add(
      CircleComponent(
        position: Vector2(150, 500),
        radius: 50,
        paint: paint,
        children: [CircleHitbox()],
      ),
    );
    add(
      RectangleComponent(
        position: Vector2.all(300),
        size: Vector2.all(100),
        paint: paint,
        children: [RectangleHitbox()],
      ),
    );
    add(
      RectangleComponent(
        position: Vector2.all(500),
        size: Vector2(100, 200),
        paint: paint,
        children: [RectangleHitbox()],
      ),
    );
    add(
      RectangleComponent(
        position: Vector2(550, 200),
        size: Vector2(200, 150),
        paint: paint,
        children: [RectangleHitbox()],
      ),
    );
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    final origin = info.eventPosition.widget;
    this.origin = origin;
  }

  var _timePassed = 0.0;

  @override
  void update(double dt) {
    super.update(dt);
    _timePassed += dt;
    paint.color = _colorTween.transform(0.5 + (sin(_timePassed) / 2))!;
    tapPaint.color = _colorTween.transform(0.5 + (cos(_timePassed) / 2))!;
    if (origin != null) {
      collisionDetection.raycastAll(
        origin!,
        numberOfRays: numberOfRays,
        startAngle: pi / 2,
        sweepAngle: -pi / 2,
        rays: rays,
        out: results,
      );
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (origin != null) {
      _renderResult(canvas, origin!, results, paint);
    }
  }

  void _renderResult(
    Canvas canvas,
    Vector2 origin,
    List<RaycastResult<ShapeHitbox>> results,
    Paint paint,
  ) {
    final originOffset = origin.toOffset();
    for (final result in results) {
      if (!result.isActive) {
        continue;
      }
      final intersectionPoint = result.intersectionPoint!.toOffset();
      canvas.drawLine(originOffset, intersectionPoint, paint);
    }
  }
}
