import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class RaycastExample extends Forge2DGame with MouseMovementDetector {
  final List<List<Vector2>> redPoints = [];
  final List<Box> boxes = [];
  Box? nearestBox;
  final int numRays = 400;

  RaycastExample() : super(gravity: Vector2.zero());

  @override
  Future<void> onLoad() async {
    super.onLoad();

    const numberOfRows = 3;
    const numberOfBoxes = 3;
    for (var i = 0; i < numberOfBoxes; ++i) {
      for (var j = 0; j < numberOfRows; ++j) {
        final box = Box(Vector2(i * 10, j * 20 - 20));
        boxes.add(box);
        world.add(box);
      }
    }

    for (int i = 0; i < numRays; i++) {
      redPoints.add([]);

      world.add(
        LineComponent(
          redPoints[i],
          Paint()
            ..color = Colors.red
            ..strokeWidth = 0.1,
        ),
      );
    }
  }

  bool done = false;

  @override
  void update(double dt) {
    super.update(dt);

    if (!done) {
      final rayStart = screenToWorld(
        Vector2(camera.viewport.size.x / 4, camera.viewport.size.y / 2),
      );

      const double rayLength = 65;
      const double degreeGap = 0.1;
      const double baseAngle = -30;

      for (int i = 0; i < numRays; i++) {
        final double angleRad = (baseAngle + i * degreeGap) * (pi / 180.0);
        final Vector2 direction = Vector2(cos(angleRad), sin(angleRad));
        final Vector2 redRayTarget = rayStart + direction * rayLength;
        _fireRedRay(rayStart, redRayTarget, redPoints[i]);
      }
      done = true;
    }

    boxes.forEach((component) {
      if (component == nearestBox) {
        component.paint.color = Colors.green;
      } else {
        component.paint.color = Colors.white;
      }
    });
  }

  /*@override
  void onMouseMove(PointerHoverInfo info) {
    final rayStart = screenToWorld(
      Vector2(camera.viewport.size.x / 4, camera.viewport.size.y / 2),
    );

    final worldPosition = screenToWorld(info.eventPosition.widget);
    final redRayTarget = worldPosition + Vector2(0, 2);
    fireRedRay(rayStart, redRayTarget);

    super.onMouseMove(info);
  }*/

  void _fireRedRay(
    Vector2 rayStart,
    Vector2 rayTarget,
    List<Vector2> redPoints,
  ) {
    redPoints.add(rayStart);

    final NearestBoxRayCastCallback nearestCallback =
        NearestBoxRayCastCallback();
    world.raycast(nearestCallback, rayStart, rayTarget);

    Vector2 endPoint;
    if (nearestCallback.nearestPoint != null) {
      endPoint = nearestCallback.nearestPoint!;
    } else {
      endPoint = rayTarget;
    }

    redPoints.add(endPoint);
    nearestBox = nearestCallback.box;
  }
}

class LineComponent extends Component {
  LineComponent(this.points, this.paint);

  final List<Vector2> points;
  final Paint paint;

  @override
  void render(Canvas canvas) {
    if (points.length == 2) {
      canvas.drawLine(points[0].toOffset(), points[1].toOffset(), paint);
    }
  }
}

class Box extends BodyComponent {
  Box(this.initialPosition);

  final Vector2 initialPosition;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(2, 4);
    final fixtureDef = FixtureDef(shape, userData: this);
    final bodyDef = BodyDef(position: initialPosition);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class NearestBoxRayCastCallback extends RayCastCallback {
  Box? box;
  Vector2? nearestPoint;

  void reset() {
    box = null;
    nearestPoint = null;
  }

  @override
  double reportFixture(
    Fixture fixture,
    Vector2 point,
    Vector2 normal,
    double fraction,
  ) {
    nearestPoint = point.clone();
    box = fixture.userData as Box?;

    // Returning fraction implies that we care only about
    // fixtures that are closer to ray start point than
    // the current fixture
    return fraction;
  }
}
