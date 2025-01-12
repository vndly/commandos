import 'dart:async';
import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/components/game_component.dart';
import 'package:cavedash/domain/components/wall_component.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/domain/models/input.dart';
import 'package:cavedash/extensions/body_component_extension.dart';
import 'package:cavedash/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class CharacterComponent extends BodyComponent<GameComponent>
    with KeyboardHandler, ContactCallbacks {
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
    add(CharacterSpriteComponent());
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
      final Vector2 deltaPosition = grid.direction! * Constants.CHARACTER_SPEED;
      body.linearVelocity = deltaPosition;

      // print(grid.remainingDistance(position));
      // Detect stop moving
      if (grid.remainingDistance(position) <
          Constants.NODE_DISTANCE_THRESHOLD) {
        grid.stop();
        body.linearVelocity = Vector2.zero();
        body.setTransform(grid.currentNode.position, angle);
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

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is WallComponent) {
      game.onMatchReset();
    }
  }
}

class CharacterSpriteComponent extends SpriteComponent {
  CharacterSpriteComponent()
      : super(
          anchor: Anchor.center,
        );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_CHARACTERS_CHARACTER);
    size = sprite!.image.size / Constants.CHARACTER_GRID_RATIO;

    return super.onLoad();
  }
}
