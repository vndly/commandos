import 'dart:ui';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/utils/platform.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

extension ComponentExtension on BodyComponent {
  Body getBody({
    required List<Vector2> vertices,
    required Vector2 initialPosition,
    required BodyType bodyType,
    required CollisionGroup group,
    double angle = 0,
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
    fixtureDef.isSensor = group.isSensor;
    fixtureDef.filter.categoryBits = group.category;
    fixtureDef.filter.maskBits = group.mask;
    fixtureDef.filter.groupIndex = group.group;

    final BodyDef bodyDef = BodyDef(
      position: initialPosition,
      type: bodyType,
      angle: angle,
    );

    final Body body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }
}
