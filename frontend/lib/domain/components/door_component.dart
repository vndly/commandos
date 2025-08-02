import 'dart:async';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class DoorComponent extends PhysicalComponent {
  DoorComponent({
    required super.size,
    required super.initialPosition,
  });

  @override
  Future onLoad() async {
    await super.onLoad();

    await level.add(
      DoorSpriteComponent(
        path: Assets.IMAGES_DOORS_DOOR_TOP,
        position: initialPosition,
        size: size,
        priority: Priority.door_top.value,
      ),
    );

    await level.add(
      DoorSpriteComponent(
        path: Assets.IMAGES_DOORS_DOOR_BOTTOM,
        position: initialPosition,
        size: size,
        priority: Priority.door_bottom.value,
      ),
    );

    await level.add(
      DoorDetector(
        size: size,
        initialPosition: position,
        priority: 0,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();
  }

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(-size.x / 2, 0),
      Vector2(size.x / 2, 0),
      Vector2(size.x / 2, size.y / 2),
      Vector2(-size.x / 2, size.y / 2),
    ]);

    return getBodyFromRelativePosition(
      shape: shape,
      center: initialPosition,
      bodyType: BodyType.kinematic,
      group: CollisionGroup.DOOR,
      angle: 0,
    );
  }
}

class DoorDetector extends PhysicalComponent with ContactCallbacks {
  DoorDetector({
    required super.size,
    required super.initialPosition,
    required super.priority,
  });

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();
  }

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(-size.x / 2, 0),
      Vector2(size.x / 2, 0),
      Vector2(size.x / 2, size.y / 2),
      Vector2(-size.x / 2, size.y / 2),
    ]);

    return getBodyFromRelativePosition(
      shape: shape,
      center: initialPosition,
      bodyType: BodyType.kinematic,
      group: CollisionGroup.DOOR,
      angle: 0,
    );
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      print('Agent has entered the door.');
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      print('Agent has exited the door.');
    }
  }
}

class DoorSpriteComponent extends SpriteComponent {
  final String path;

  DoorSpriteComponent({
    required this.path,
    required super.position,
    required super.size,
    required super.priority,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(path);

    return super.onLoad();
  }
}
