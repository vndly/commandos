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
  Paint rayPaint = Paint();

  static const numberOfRays = 2000;
  final List<Ray2> rays = [];
  final List<Ray2> tapRays = [];
  final List<RaycastResult<ShapeHitbox>> results = [];
  final List<RaycastResult<ShapeHitbox>> tapResults = [];

  @override
  Future<void> onLoad() async {
    rayPaint.color = Colors.green;

    final Paint paint = BasicPalette.gray.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white;

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
    origin = info.eventPosition.widget;
  }

  @override
  void update(double dt) {
    super.update(dt);

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
      _renderResult(canvas, origin!, results, rayPaint);
    }
  }

  void _renderResult(
    Canvas canvas,
    Vector2 origin,
    List<RaycastResult<ShapeHitbox>> results,
    Paint paint,
  ) {
    final Offset originOffset = origin.toOffset();

    for (final RaycastResult<ShapeHitbox> result in results) {
      if (result.isActive) {
        final Offset intersectionPoint = result.intersectionPoint!.toOffset();
        canvas.drawLine(originOffset, intersectionPoint, paint);
      }
    }
  }
}
