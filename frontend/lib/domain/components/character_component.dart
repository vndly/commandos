import 'dart:ui';
import 'package:flame_forge2d/flame_forge2d.dart';

class CharacterComponent extends BodyComponent {
  final Vector2 initialPosition;
  final Vector2 size;

  CharacterComponent({
    required this.initialPosition,
    required this.size,
  });

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(-size.x / 2, size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(0, -size.y / 2),
      Vector2(0, -size.y / 2),
    ]);

    final FixtureDef fixtureDef = FixtureDef(
      shape,
      userData: this,
      restitution: 0.4,
      friction: 0.5,
    );

    final BodyDef bodyDef = BodyDef(
      position: position,
      angle: 0,
      type: BodyType.dynamic,
    );

    final Body body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(position.x, position.y),
        width: size.x,
        height: size.y,
      ),
      Paint()..color = const Color(0xFFFF0000),
    );
  }
}
