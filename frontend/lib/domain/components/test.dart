import 'dart:math';
import 'package:flame_forge2d/flame_forge2d.dart';

class Pizza extends BodyComponent {
  final Vector2 initialPosition;
  final Vector2 size;

  Pizza(
    this.initialPosition, {
    Vector2? size,
  }) : size = size ?? Vector2(2, 3);

  @override
  Body createBody() {
    final shape = PolygonShape();

    final vertices = [
      Vector2(-size.x / 2, size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(0, -size.y / 2),
    ];
    shape.set(vertices);

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0.4,
      friction: 0.5,
    );

    final bodyDef = BodyDef(
      position: initialPosition,
      angle: (initialPosition.x + initialPosition.y) / 2 * pi,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}