import 'dart:async';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/vision_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class SoldierComponent extends BodyComponent<GameComponent> {
  late final RayCasting rayCasting;
  final Vector2 initialPosition;
  final Vector2 size;
  final Soldier soldier;
  late final VisionComponent vision;

  SoldierComponent({
    required this.initialPosition,
    required this.size,
    required this.soldier,
  }) : super(priority: Priority.soldier.value);

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);

    await add(
      SoldierSpriteComponent(
        soldier: soldier,
        size: size,
      ),
    );

    vision = VisionComponent(
      sweep: soldier.sweep,
      range: soldier.range,
    );
    await world.add(vision);
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    angle: soldier.angle,
    group: CollisionGroup.SOLDIER,
  );

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();

    for (final Behavior behavior in soldier.behaviors) {
      behavior.update(body, dt);
    }

    vision.show(
      source: body.position,
      angle: body.angle,
      rayCasting: rayCasting,
    );
  }
}

class SoldierSpriteComponent extends SpriteComponent {
  final Soldier soldier;

  SoldierSpriteComponent({
    required this.soldier,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_TURRETS_SINGLE);

    return super.onLoad();
  }
}
