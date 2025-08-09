import 'dart:async';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/door_opened_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/types/item_type.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/audio.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class DoorClosedComponent extends PhysicalComponent with ContactCallbacks {
  final Door door;

  DoorClosedComponent({
    required this.door,
  }) : super(
         position: door.position,
         size: door.size,
         priority: Priority.door.value,
       );

  @override
  Future onLoad() async {
    await super.onLoad();

    add(
      DoorSpriteComponent(
        doorComponent: this,
        position: size / 2,
        size: size,
      ),
    );
  }

  @override
  void onRemoved() {
    level.add(DoorOpenedComponent(door: door));
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeSquare(door.size),
    center: initialPosition,
    bodyType: BodyType.static,
    group: CollisionGroup.DOOR_CLOSED,
    angle: 0,
  );

  @override
  void beginContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      final bool hasKeycard = other.agent.backpack.contains(ItemType.keycard);

      if (hasKeycard) {
        other.agent.backpack.remove(ItemType.keycard);
        level.onBackpackUpdated();
        Audio.get.playSound(Audio.DOOR_UNLOCKED);
        Future.delayed(const Duration(milliseconds: 1000), toBeRemoved);
      } else {
        Audio.get.playSound(Audio.DOOR_LOCKED);
      }
    }
  }
}

class DoorSpriteComponent extends PositionComponent {
  final DoorClosedComponent doorComponent;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.DOOR_CLOSED,
  );

  DoorSpriteComponent({
    required this.doorComponent,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  Future onLoad() async {
    await super.onLoad();

    await add(
      DoorIconComponent(
        position: Vector2.zero(),
        size: Vector2(5, 5),
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawPath(doorComponent.door.path, paintFill);
  }
}

class DoorIconComponent extends SpriteComponent {
  DoorIconComponent({
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  Future onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load(Assets.IMAGES_ICONS_LOCKED);
  }
}
