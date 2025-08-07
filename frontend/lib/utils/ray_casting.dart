import 'dart:math';
import 'package:flame_forge2d/flame_forge2d.dart';

class RayCasting {
  final NearestBoxRayCastCallback rayCastCallback = NearestBoxRayCastCallback();
  final Forge2DWorld world;

  RayCasting(this.world);

  RayCastingResult test({
    required Vector2 source,
    required double angle,
    required double range,
  }) {
    final Vector2 direction = Vector2(cos(angle), sin(angle));
    final Vector2 maxTarget = source + (direction * range);

    rayCastCallback.reset();
    world.raycast(rayCastCallback, source, maxTarget);

    return RayCastingResult(
      start: source,
      end: rayCastCallback.nearestPoint ?? maxTarget,
      angle: angle,
      object: rayCastCallback.object,
    );
  }
}

class RayCastingResult {
  final Vector2 start;
  final Vector2 end;
  final double angle;
  final Object? object;

  const RayCastingResult({
    required this.start,
    required this.end,
    required this.angle,
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
