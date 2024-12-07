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
  Future onLoad() async {
    await super.onLoad();
    renderBody = debugMode;

    paint.color = const Color(0xff00ff00);
    paint.style = PaintingStyle.stroke;
  }

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(0, -size.y / 2),
      Vector2(size.x / 2, 0),
      Vector2(0, size.y / 2),
      Vector2(-size.x / 2, 0),
    ]);

    final FixtureDef fixtureDef = FixtureDef(
      shape,
      userData: this,
    );

    final BodyDef bodyDef = BodyDef(
      position: initialPosition.clone(),
      type: BodyType.dynamic,
    );

    final Body body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }

  /*@override
  void render(Canvas canvas) {
    super.render(canvas);

    /*final Paint paint = Paint();
    paint.color = const Color(0xffff0000);
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;

    final Rect visibleRect = camera.visibleWorldRect;
    canvas.drawRect(visibleRect, paint);*/

    /*canvas.drawCircle(
      Offset.zero,
      1,
      Paint()..color = const Color(0xFFFF0000),
    );*/
  }*/
}
