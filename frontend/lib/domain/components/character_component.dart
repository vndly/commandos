import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/domain/models/input.dart';
import 'package:cavedash/extensions/body_component_extension.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class CharacterComponent extends BodyComponent with KeyboardHandler {
  final Vector2 size;
  final Grid grid;
  final Vector2 velocity = Vector2.zero();
  final Input input = Input();

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
    if (input.isMoving && !grid.isMoving) {
      grid.move(
        state: input.state,
        position: position,
      );
    }

    // Detect moving
    if (grid.isMoving) {
      final Vector2 deltaPosition =
          grid.direction! * Constants.CHARACTER_SPEED * dt;
      position.add(deltaPosition);

      // print(grid.remainingDistance(position));
      // Detect stop moving
      if (grid.remainingDistance(position) <
          Constants.NODE_DISTANCE_THRESHOLD) {
        grid.stop();
        position.setFrom(grid.currentNode.position);
        input.state = InputState.none;
      }
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
    if (input.onKeyEvent(event, keysPressed)) {
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }

  void onPanUpdate(DragUpdateInfo info) => input.onPanUpdate(info.raw.delta);

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
