import 'dart:ui';
import 'package:commandos/app/debug.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

extension ComponentExtension on BodyComponent {
  Body getBodyFromRelativePosition({
    required Shape shape,
    required Vector2 center,
    required BodyType bodyType,
    required CollisionGroup group,
    double angle = 0,
  }) => _getBody(
    shape: shape,
    center: center,
    bodyType: bodyType,
    group: group,
    angle: angle,
  );

  Body getBodyFromAbsolutePosition({
    required List<Vector2> vertices,
    required BodyType bodyType,
    required CollisionGroup group,
    double angle = 0,
  }) {
    final Vector2 center = _getCenter(vertices);
    final List<Vector2> centeredVertices = vertices
        .map((v) => v - center)
        .toList();

    final PolygonShape shape = PolygonShape();
    shape.set(centeredVertices);

    return _getBody(
      shape: shape,
      center: center,
      bodyType: bodyType,
      group: group,
      angle: angle,
    );
  }

  Body _getBody({
    required Shape shape,
    required Vector2 center,
    required BodyType bodyType,
    required CollisionGroup group,
    double angle = 0,
  }) {
    final FixtureDef fixtureDef = FixtureDef(shape, userData: this);
    fixtureDef.isSensor = group.isSensor;
    fixtureDef.filter.categoryBits = group.category;
    fixtureDef.filter.maskBits = group.mask;
    fixtureDef.filter.groupIndex = group.group;

    final BodyDef bodyDef = BodyDef(
      position: center,
      type: bodyType,
      angle: angle,
    );

    final Body body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }

  Vector2 _getCenter(List<Vector2> vertices) {
    double sumX = 0;
    double sumY = 0;

    for (final Vector2 vertex in vertices) {
      sumX += vertex.x;
      sumY += vertex.y;
    }

    return Vector2(sumX / vertices.length, sumY / vertices.length);
  }

  CircleShape shapeCircle(Vector2 size) {
    final CircleShape shape = CircleShape();
    shape.radius = size.x / 2;

    return shape;
  }

  PolygonShape shapeSquare(Vector2 size) {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(-size.x / 2, -size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(-size.x / 2, size.y / 2),
    ]);

    return shape;
  }

  PolygonShape shapeRombus(Vector2 size) {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(0, -size.y / 2),
      Vector2(size.x / 2, 0),
      Vector2(0, size.y / 2),
      Vector2(-size.x / 2, 0),
    ]);

    return shape;
  }

  void checkDebug() {
    renderBody = Debug.hasBodyDebug;

    if (renderBody) {
      paint.color = const Color(0xff00ff00);
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 0.3;
    }
  }
}
