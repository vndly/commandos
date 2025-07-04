import 'dart:async';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';

class CharacterComponent extends BodyComponent<GameComponent>
    with KeyboardHandler {
  final Vector2 initialPosition;
  final Vector2 size;
  final Vector2 velocity = Vector2.zero();
  final Input input = Input();
  final List<Node> nodes;
  late final CharacterMovement movement;

  CharacterComponent({
    required this.initialPosition,
    required this.size,
    required this.nodes,
  }) {
    movement = CharacterMovement(
      nodes: nodes,
      character: this,
      initialPosition: initialPosition,
    );
  }

  @override
  Future onLoad() async {
    await super.onLoad();
    setup();
    add(CharacterSpriteComponent(size: size));
  }

  @override
  void update(double dt) {
    super.update(dt);
    movement.update(input);
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
      position: initialPosition,
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
}

class CharacterSpriteComponent extends SpriteComponent {
  CharacterSpriteComponent({super.size}) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_CHARACTERS_CHARACTER);

    return super.onLoad();
  }
}

class CharacterMovement {
  final List<Node> nodes;
  final CharacterComponent character;
  late Node currentNode;
  Vector2 direction = Vector2.zero();
  bool isMoving = false;
  Node? nextNode;

  CharacterMovement({
    required this.nodes,
    required this.character,
    required Vector2 initialPosition,
  }) {
    currentNode = _getNodeAt(
      nodes: nodes,
      position: initialPosition,
    );
  }

  void update(Input input) {
    if (input.hasInput && !isMoving) {
      isMoving = true;
      nextNode = currentNode.nodeAt(input.direction);
      direction = input.direction;
      final Vector2 deltaPosition = input.direction * 500;
      character.body.linearVelocity = deltaPosition;
    }

    if (isMoving) {
      final Vector2 currentPosition = character.body.position;
      final Vector2 targetPosition = nextNode!.position;
      final Vector2 toTarget = targetPosition - currentPosition;

      if (toTarget.length < 1) {
        character.body.linearVelocity = Vector2.zero();
        character.body.setTransform(targetPosition, character.body.angle);
        isMoving = false;
        currentNode = nextNode!;
        nextNode = null;
      }
    }
  }

  static Node _getNodeAt({
    required List<Node> nodes,
    required Vector2 position,
  }) {
    for (final Node node in nodes) {
      if (node.position == position) {
        return node;
      }
    }
    throw Exception('Node not found for position: $position');
  }
}
