import 'dart:async';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/components/laser_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class TurretComponent extends EnemyComponent {
  final Turret turret;
  final List<LaserComponent> lasers = [];

  TurretComponent({
    required super.initialPosition,
    required super.size,
    required this.turret,
  }) : super(priority: Priority.turret.value, facingAngle: turret.angle);

  @override
  Future onLoad() async {
    await super.onLoad();

    await add(
      TurretSpriteComponent(
        turret: turret,
        size: size,
      ),
    );

    for (final Laser laser in turret.lasers) {
      final LaserComponent laserComponent = LaserComponent(
        laser: laser,
      );
      lasers.add(laserComponent);
      await world.add(laserComponent);
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    angle: turret.angle,
    group: CollisionGroup.TURRET,
  );

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();

    for (final Behavior behavior in turret.behaviors) {
      behavior.update(this, dt);
    }

    for (final LaserComponent laser in lasers) {
      laser.show(
        source: body.position,
        angle: body.angle,
        rayCasting: rayCasting,
      );
    }
  }
}

class TurretSpriteComponent extends SpriteComponent {
  final Turret turret;

  TurretSpriteComponent({
    required this.turret,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_TURRETS_SINGLE);

    return super.onLoad();
  }
}
