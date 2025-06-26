import 'dart:async';
import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/components/game_component.dart';
import 'package:cavedash/domain/components/portal_component.dart';
import 'package:cavedash/domain/components/wall_component.dart';
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
  final Vector2 velocity = Vector2.zero();
  final Input input = Input();
  Vector2? teleportTo;

  CharacterComponent({required this.size});

  @override
  Future onLoad() async {
    await super.onLoad();
    setup();
    add(CharacterSpriteComponent());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (teleportTo != null) {
      body.clearForces();
      body.setTransform(teleportTo!, angle);

      teleportTo = null;
    } else if (input.hasInput) {
      final Vector2 deltaPosition = input.direction * Constants.CHARACTER_SPEED;
      body.linearVelocity = deltaPosition;
    } else {
      body.linearVelocity = Vector2.zero();
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

    final FixtureDef fixtureDef = FixtureDef(shape, userData: this);

    final BodyDef bodyDef = BodyDef(
      position: Constants.MAP_CENTER,
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
    } else if (other is PortalComponent) {
      _teleport(other);
    }
  }

  void _teleport(PortalComponent portal) {
    teleportTo = portal.portal.destination(position);
  }
}

class CharacterSpriteComponent extends SpriteComponent {
  CharacterSpriteComponent() : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_CHARACTERS_CHARACTER);
    size = sprite!.image.size / Constants.CHARACTER_GRID_RATIO;

    return super.onLoad();
  }
}
