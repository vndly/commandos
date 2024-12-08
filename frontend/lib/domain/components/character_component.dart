import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/models/input.dart';
import 'package:cavedash/extensions/body_component_extension.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class CharacterComponent extends BodyComponent with KeyboardHandler {
  final Vector2 initialPosition;
  final Vector2 size;
  final Vector2 velocity = Vector2.zero();
  final Input input = Input();

  CharacterComponent({
    required this.initialPosition,
    required this.size,
  });

  @override
  Future onLoad() async {
    await super.onLoad();
    setup();

    camera.moveTo(initialPosition);
    camera.follow(
      this,
      maxSpeed: Constants.CAMERA_SPEED,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!input.state.isNone) {
      final Vector2 deltaPosition =
          _velocity(input.state) * Constants.CHARACTER_SPEED * dt;
      position.add(deltaPosition);
    }
  }

  Vector2 _velocity(InputState state) {
    switch (state) {
      case InputState.left:
        return Vector2(-1, 0);
      case InputState.right:
        return Vector2(1, 0);
      case InputState.up:
        return Vector2(0, -1);
      case InputState.down:
        return Vector2(0, 1);
      default:
        return Vector2.zero();
    }
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

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (input.onKeyEvent(keysPressed)) {
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }

  /*@override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint paint = Paint();
    paint.color = const Color(0xffff0000);
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;

    canvas.drawRect(camera.visibleWorldRect, paint);

    /*canvas.drawCircle(
      Offset.zero,
      1,
      Paint()..color = const Color(0xFFFF0000),
    );*/
  }*/
}
