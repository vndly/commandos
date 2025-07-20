import 'dart:async';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class TurretComponent extends BodyComponent<GameComponent> {
  final Vector2 initialPosition;
  final Vector2 size;
  final Turret turret;

  TurretComponent({
    required this.initialPosition,
    required this.size,
    required this.turret,
  });

  @override
  Future onLoad() async {
    await super.onLoad();
    await add(
      TurretSpriteComponent(
        turret: turret,
        size: size,
        angle: radians(turret.angle),
      ),
    );
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    vertices: [
      Vector2(-size.x / 2, -size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(-size.x / 2, size.y / 2),
    ],
    center: initialPosition,
    bodyType: BodyType.dynamic,
    angle: radians(turret.angle),
    group: CollisionGroup.TURRET,
  );
}

class TurretSpriteComponent extends SpriteComponent {
  final Turret turret;

  TurretSpriteComponent({
    required this.turret,
    required super.size,
    required super.angle,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_TURRETS_TURRET);

    return super.onLoad();
  }
}
