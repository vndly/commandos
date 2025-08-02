import 'dart:async';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class ItemComponent extends PhysicalComponent {
  final Item item;

  ItemComponent({
    required this.item,
  }) : super(
         size: Vector2(5, 5),
         priority: Priority.item.value,
         position: item.position,
       );

  @override
  Future onLoad() async {
    await super.onLoad();

    await add(
      ItemSpriteComponent(
        item: item,
        size: size,
      ),
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

class ItemSpriteComponent extends SpriteComponent {
  final Item item;

  ItemSpriteComponent({
    required this.item,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.item.value,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(item.type.sprite);

    return super.onLoad();
  }
}
