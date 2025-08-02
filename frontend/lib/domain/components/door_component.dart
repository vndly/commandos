import 'dart:async';
import 'package:commandos/app/constants.dart';
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
  DoorStatus status = DoorStatus.closed;
  late final DoorSpriteComponent topDoor;
  late final DoorSpriteComponent bottomDoor;

  DoorComponent({
    required super.size,
    required super.position,
  });

  @override
  Future onLoad() async {
    await super.onLoad();

    topDoor = DoorSpriteComponent(
      path: Assets.IMAGES_DOORS_DOOR_TOP,
      position: position,
      size: size,
      priority: Priority.door_top.value,
    );

    bottomDoor = DoorSpriteComponent(
      path: Assets.IMAGES_DOORS_DOOR_BOTTOM,
      position: position,
      size: size,
      priority: Priority.door_bottom.value,
    );

    await level.add(topDoor);
    await level.add(bottomDoor);
    await level.add(
      DoorDetector(
        doorComponent: this,
        size: size,
        position: position,
        priority: 0,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();

    if (status == DoorStatus.opening) {
      body.linearVelocity = Vector2(-1, 0) * Constants.DOOR_SPEED;

      if (position.x <= initialPosition.x - size.x) {
        status = DoorStatus.open;
        body.linearVelocity = Vector2.zero();
        position.x = initialPosition.x - size.x;
      }
    } else if (status == DoorStatus.closing) {
      body.linearVelocity = Vector2(1, 0) * Constants.DOOR_SPEED;

      if (position.x >= initialPosition.x) {
        status = DoorStatus.closed;
        body.linearVelocity = Vector2.zero();
        position.x = initialPosition.x;
      }
    }

    topDoor.position = position;
    bottomDoor.position = position;
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

  void onAgentEnter() {
    if (status == DoorStatus.closed) {
      status = DoorStatus.opening;
    }
  }

  void onAgentExit() {
    if (status == DoorStatus.open) {
      status = DoorStatus.closing;
    }
  }
}

class DoorDetector extends PhysicalComponent with ContactCallbacks {
  final DoorComponent doorComponent;

  DoorDetector({
    required this.doorComponent,
    required super.size,
    required super.position,
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
      bodyType: BodyType.static,
      group: CollisionGroup.DOOR_DETECTOR,
      angle: 0,
    );
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      doorComponent.onAgentEnter();
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      doorComponent.onAgentExit();
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

enum DoorStatus {
  closed,
  opening,
  open,
  closing,
}
