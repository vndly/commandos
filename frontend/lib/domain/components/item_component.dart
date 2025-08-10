import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/types/item_type.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/presentation/audio/audio.dart';
import 'package:commandos/presentation/audio/sound.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class ItemComponent extends PhysicalComponent with ContactCallbacks {
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
        item: item.type,
        position: Vector2.zero(),
        size: Vector2(8, 8),
      ),
    );
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.static,
    group: CollisionGroup.ITEM,
    angle: 0,
  );

  @override
  void beginContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      Audio.get.playSound(Sound.PICK_ITEM);
      toBeRemoved();
      other.agent.backpack.add(item.type);
      level.onBackpackUpdated();
    }
  }
}

class ItemSpriteComponent extends SpriteComponent {
  final ItemType item;

  ItemSpriteComponent({
    required this.item,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  Future onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load(item.path);
  }
}
