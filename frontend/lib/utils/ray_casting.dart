import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class RayCasting {
  final NearestBoxRayCastCallback rayCastCallback = NearestBoxRayCastCallback();
  final Forge2DWorld world;

  RayCasting(this.world);

  RayCastingResult test({
    required Vector2 source,
    required double angle,
    required double gap,
    required double length,
  }) {
    final double angleAdustment = radians(-90);
    final Vector2 direction = Vector2(
      cos(angle + angleAdustment),
      sin(angle + angleAdustment),
    );
    final Vector2 startPoint = source + direction * gap;
    final Vector2 maxTarget = startPoint + (direction * length);

    rayCastCallback.reset();
    world.raycast(rayCastCallback, startPoint, maxTarget);

    return RayCastingResult(
      start: startPoint,
      end: rayCastCallback.nearestPoint ?? maxTarget,
      object: rayCastCallback.object,
    );
  }
}

class RayCastingResult {
  final Vector2 start;
  final Vector2 end;
  final Object? object;

  const RayCastingResult({
    required this.start,
    required this.end,
    required this.object,
  });
}

class NearestBoxRayCastCallback extends RayCastCallback {
  Object? object;
  Vector2? nearestPoint;

  void reset() {
    object = null;
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
    object = fixture.userData;

    // Returning fraction implies that we care only about fixtures
    // that are closer to the ray start point than the current fixture
    return fraction;
  }
}
