import 'package:cavedash/app/constants.dart';
import 'package:cavedash/extensions/body_component_extension.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class CharacterComponent extends BodyComponent with KeyboardHandler {
  final Vector2 initialPosition;
  final Vector2 size;
  final Vector2 velocity = Vector2.zero();
  MovingState movingState = MovingState.still;

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

    if (movingState != MovingState.still) {
      final Vector2 deltaPosition =
          _velocity(dt) * Constants.CHARACTER_SPEED * dt;
      position.add(deltaPosition);
    }
  }

  Vector2 _velocity(double dt) {
    switch (movingState) {
      case MovingState.left:
        return Vector2(-1, 0);
      case MovingState.right:
        return Vector2(1, 0);
      case MovingState.up:
        return Vector2(0, -1);
      case MovingState.down:
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
    //final bool isKeyDown = event is KeyDownEvent;
    bool handled = false;

    /*if (isKeyDown) {
      if ((event.logicalKey == LogicalKeyboardKey.keyA) ||
          (event.logicalKey == LogicalKeyboardKey.arrowLeft)) {
        movingState = MovingState.left;
        //velocity.x = isKeyDown ? -1 : 0;
        handled = true;
      } else if ((event.logicalKey == LogicalKeyboardKey.keyD) ||
          (event.logicalKey == LogicalKeyboardKey.arrowRight)) {
        movingState = MovingState.right;
        //velocity.x = isKeyDown ? 1 : 0;
        handled = true;
      } else if ((event.logicalKey == LogicalKeyboardKey.keyW) ||
          (event.logicalKey == LogicalKeyboardKey.arrowUp)) {
        movingState = MovingState.up;
        //velocity.y = isKeyDown ? -1 : 0;
        handled = true;
      } else if ((event.logicalKey == LogicalKeyboardKey.keyS) ||
          (event.logicalKey == LogicalKeyboardKey.arrowDown)) {
        movingState = MovingState.left;
        //velocity.y = isKeyDown ? 1 : 0;
        handled = true;
      }
    } else {
      movingState = MovingState.still;
    }*/

    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      movingState = MovingState.left;
      handled = true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      movingState = MovingState.right;
      handled = true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      movingState = MovingState.up;
      handled = true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      movingState = MovingState.down;
      handled = true;
    } else {
      movingState = MovingState.still;
    }

    if (handled) {
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

enum MovingState {
  still,
  left,
  right,
  up,
  down,
}
