import 'dart:async';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/components/laser_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class TurretComponent extends EnemyComponent {
  final Turret turret;
  final List<LaserComponent> lasers = [];
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.TURRET,
  );
  final Paint paintOrientation = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 0.5,
    color: Palette.ORIENTATION,
  );

  TurretComponent({
    required this.turret,
  }) : super(
         position: turret.position,
         size: Vector2(10, 10),
         priority: Priority.turret.value,
       );

  @override
  Future onLoad() async {
    await super.onLoad();

    for (final Laser laser in turret.lasers) {
      final LaserComponent laserComponent = LaserComponent(laser: laser);
      lasers.add(laserComponent);
      await level.add(laserComponent);
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    group: CollisionGroup.TURRET,
    angle: turret.angle,
  );

  @override
  void update(double dt) {
    super.update(dt);

    for (final Behavior behavior in turret.behaviors) {
      behavior.update(this, dt);
    }

    for (final LaserComponent laser in lasers) {
      laser.refresh(
        dt: dt,
        source: body.position,
        angle: body.angle,
        rayCasting: rayCasting,
      );
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      Offset.zero,
      size.x / 2,
      paintFill,
    );

    canvas.drawLine(
      Offset.zero,
      Offset(0, -size.y / 2),
      paintOrientation,
    );
  }
}
