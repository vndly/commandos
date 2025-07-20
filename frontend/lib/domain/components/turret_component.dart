import 'dart:async';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/laser_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class TurretComponent extends BodyComponent<GameComponent> {
  late final RayCasting rayCasting;
  final Vector2 initialPosition;
  final Vector2 size;
  final Turret turret;
  final List<LaserComponent> lasers = [];

  TurretComponent({
    required this.initialPosition,
    required this.size,
    required this.turret,
  });

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);

    await add(
      TurretSpriteComponent(
        turret: turret,
        size: size,
      ),
    );

    for (final Laser laser in turret.lasers) {
      final LaserComponent laserComponent = LaserComponent(
        laser: laser,
        start: Vector2.zero(),
        end: Vector2.zero(),
      );
      lasers.add(laserComponent);
      await world.add(laserComponent);
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    vertices: shapeSquare(size),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    angle: turret.angle,
    group: CollisionGroup.TURRET,
  );

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();

    final double newAngle = body.angle + radians(50 * dt);
    body.setTransform(position, newAngle);

    for (final LaserComponent laser in lasers) {
      final RayCastingResult result = rayCasting.test(
        source: body.position,
        angle: body.angle + laser.laser.angle,
        gap: size.x / 2,
        length: laser.laser.length,
      );
      laser.updatePoints(start: result.start, end: result.end);
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
    sprite = await Sprite.load(Assets.IMAGES_TURRETS_TURRET);

    return super.onLoad();
  }
}
