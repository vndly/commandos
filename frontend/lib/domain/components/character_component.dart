import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/domain/models/input.dart';
import 'package:cavedash/extensions/body_component_extension.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class CharacterComponent extends BodyComponent with KeyboardHandler {
  final Vector2 size;
  final Grid grid;
  final Vector2 velocity = Vector2.zero();
  final Input input = Input();
  MovingState movingState = MovingState.still;

  CharacterComponent({
    required this.size,
    required this.grid,
  });

  @override
  Future onLoad() async {
    await super.onLoad();
    setup();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Detect start moving
    if (input.isMoving && movingState.isStill) {
      movingState = grid.move(input.state);
    }

    // Move
    if (grid.isMoving) {
      final Vector2 deltaPosition =
          _velocity(movingState) * Constants.CHARACTER_SPEED * dt;
      position.add(deltaPosition);

      // print(grid.remainingDistance(position));
      // Detect stop moving
      if (grid.remainingDistance(position) <
          Constants.NODE_DISTANCE_THRESHOLD) {
        grid.stop();
        position.setFrom(grid.currentNode.position);
        movingState = MovingState.still;
      }
    }
  }

  Vector2 _velocity(MovingState state) {
    switch (state) {
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
      position: grid.startPosition.clone(),
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

enum MovingState {
  still,
  left,
  right,
  up,
  down;

  bool get isStill => this == MovingState.still;
}
