import 'dart:ui';
import 'package:commandos/app/constants.dart';
import 'package:commandos/utils/platform.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

extension ComponentExtension on BodyComponent {
  Body getBody({
    required List<Vector2> vertices,
    required Vector2 initialPosition,
    required BodyType bodyType,
  }) {
    renderBody = Constants.RENDER_BODIES && Platform.isDebugMode;

    if (renderBody) {
      paint.color = const Color(0xff00ff00);
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 0.3;
    }

    final PolygonShape shape = PolygonShape();
    shape.set(vertices);

    final FixtureDef fixtureDef = FixtureDef(shape, userData: this);

    final BodyDef bodyDef = BodyDef(
      position: initialPosition,
      type: bodyType,
    );

    final Body body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }
}
