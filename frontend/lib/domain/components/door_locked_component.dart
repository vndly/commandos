import 'dart:async';
import 'package:commandos/domain/components/door_unlocked_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class DoorLockedComponent extends PhysicalComponent {
  final Door door;

  DoorLockedComponent({
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
    level.add(DoorUnlockedComponent(door: door));
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeSquare(door.size),
    center: initialPosition,
    bodyType: BodyType.static,
    group: CollisionGroup.DOOR_LOCKED,
    angle: 0,
  );
}

class DoorSpriteComponent extends PositionComponent {
  final DoorLockedComponent doorComponent;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.DOOR_LOCKED,
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
        size: Vector2(7, 7),
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
