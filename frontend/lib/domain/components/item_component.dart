import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/canvas_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class ItemComponent extends PhysicalComponent {
  final Item item;

  ItemComponent({
    required this.item,
  }) : super(
         position: item.position,
         size: Vector2(5, 5),
         priority: Priority.item.value,
       );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: item.type.value,
      position: position,
      size: size.x / 10,
      color: Colors.white,
    );
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    angle: 0,
    group: CollisionGroup.ITEM,
  );
}
