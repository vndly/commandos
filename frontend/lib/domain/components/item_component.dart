import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/canvas_extension.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class ItemComponent extends PhysicalComponent {
  final Item item;

  ItemComponent({
    required this.item,
  }) : super(
         position: item.position,
         size: Vector2(10, 10),
         priority: Priority.item.value,
       );

  @override
  Future onLoad() async {
    await super.onLoad();

    add(
      ItemSpriteComponent(
        item: item,
        position: size / 2,
        size: size,
      ),
    );
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.static,
    angle: 0,
    group: CollisionGroup.ITEM,
  );
}

class ItemSpriteComponent extends PositionComponent {
  final Item item;

  ItemSpriteComponent({
    required this.item,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: item.type.value,
      position: Vector2.zero(),
      size: size.x / 1.2,
    );
  }
}
