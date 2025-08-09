import 'dart:async';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/components/vision_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class SoldierComponent extends EnemyComponent {
  final Soldier soldier;
  final List<AgentComponent> agents;
  late final VisionComponent vision;
  AgentComponent? agentInVision;

  SoldierComponent({
    required this.soldier,
    required this.agents,
  }) : super(
         position: soldier.position,
         size: Vector2(10, 10),
         priority: Priority.soldier.value,
       );

  bool inFieldOfView(double angle) {
    final double minAngle = body.angle - soldier.sweep;
    final double maxAngle = body.angle + soldier.sweep;

    return angle >= minAngle && angle <= maxAngle;
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    add(
      SoldierSpriteComponent(
        soldier: soldier,
        position: size / 2,
        size: size,
      ),
    );

    vision = VisionComponent(
      agents: agents,
      soldierComponent: this,
    );
    await level.add(vision);
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    group: CollisionGroup.SOLDIER,
    angle: soldier.angle,
  );

  @override
  void update(double dt) {
    super.update(dt);

    agentInVision = vision.refresh(
      source: body.position,
      angle: body.angle,
      rayCasting: rayCasting,
    );

    if (agentInVision != null) {
      level.onAgentSpotted(dt * Constants.ALARM_RATIO_SOLDIER);
    } else {
      for (final Behavior behavior in soldier.behaviors) {
        behavior.update(this, dt);
      }
    }
  }
}

class SoldierSpriteComponent extends PositionComponent {
  final Soldier soldier;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.SOLDIER,
  );

  SoldierSpriteComponent({
    required this.soldier,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      Offset.zero,
      size.x / 2,
      paintFill,
    );
  }
}
