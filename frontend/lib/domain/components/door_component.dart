import 'dart:async';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class DoorComponent extends PositionComponent {
  final String pathTop;
  final String pathBottom;

  DoorComponent({
    required this.pathTop,
    required this.pathBottom,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    await add(
      DoorPanel(
        size: size,
        initialPosition: position,
      ),
    );

    return super.onLoad();
  }
}

class DoorPanel extends BodyComponent {
  final Vector2 size;
  final Vector2 initialPosition;

  DoorPanel({
    required this.size,
    required this.initialPosition,
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
      Vector2(-size.x / 2, -size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
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

class DoorSpriteComponent extends SpriteComponent {
  final String path;

  DoorSpriteComponent({
    required this.path,
    required super.position,
    required super.size,
    required super.priority,
  }) : super(
         anchor: Anchor.center,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(path);

    return super.onLoad();
  }
}
