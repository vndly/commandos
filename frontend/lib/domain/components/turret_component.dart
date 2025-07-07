import 'dart:async';
import 'package:commandos/domain/components/game_component.dart';
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
      ),
    );
  }

  @override
  Body createBody() => getBody(
    vertices: [
      Vector2(-size.x / 2, -size.y / 2),
      Vector2(size.x / 2, -size.y / 2),
      Vector2(size.x / 2, size.y / 2),
      Vector2(-size.x / 2, size.y / 2),
    ],
    initialPosition: initialPosition,
    bodyType: BodyType.kinematic,
    angle: radians(turret.angle),
  );
}

class TurretSpriteComponent extends SpriteComponent {
  final Turret turret;

  TurretSpriteComponent({required this.turret, required super.size})
    : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_TURRETS_TURRET);

    return super.onLoad();
  }
}
