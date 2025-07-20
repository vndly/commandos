import 'dart:async';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/laser_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class TurretComponent extends BodyComponent<GameComponent> {
  final NearestBoxRayCastCallback rayCastCallback = NearestBoxRayCastCallback();
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
    await add(
      TurretSpriteComponent(
        turret: turret,
        size: size,
      ),
    );

    for (final Laser laser in turret.lasers) {
      final LaserComponent laserComponent = LaserComponent(
        laser: laser,
        start: initialPosition,
        end: initialPosition + Vector2(0, 1) * 25,
      );
      lasers.add(laserComponent);
      await add(laserComponent);
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    vertices: shapeSquare(size),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    angle: radians(turret.angle),
    group: CollisionGroup.TURRET,
  );

  /*@override
  void update(double dt) {
    super.update(dt);

    for (final LaserComponent laser in lasers) {
      final Vector2 direction = Vector2(
        cos(body.angle + laser.laser.angle),
        sin(body.angle + laser.laser.angle),
      );
      final Vector2 startPoint = body.position;
      final Vector2 rayTarget = startPoint + direction * laser.laser.length;
      world.raycast(rayCastCallback, startPoint, rayTarget);
      final Vector2 endPoint = rayCastCallback.nearestPoint ?? rayTarget;
      laser.updatePoints(start: startPoint, end: endPoint);
    }
  }*/
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
