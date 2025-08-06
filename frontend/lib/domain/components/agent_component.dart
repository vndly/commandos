import 'dart:async';
import 'package:commandos/app/constants.dart';
import 'package:commandos/app/debug.dart';
import 'package:commandos/domain/components/laser_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class AgentComponent extends PhysicalComponent {
  final Vector2 velocity = Vector2.zero();
  final Input input;
  final Agent agent;
  late final LaserComponent laser;
  late final RayCasting rayCasting;
  bool active;

  AgentComponent({
    required super.position,
    required this.input,
    required this.agent,
    required this.active,
  }) : super(size: Vector2(10, 10), priority: Priority.agent.value);

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);

    add(
      AgentSpriteComponent(
        position: size / 2,
        agent: agent,
      ),
    );

    laser = LaserComponent(
      laser: const Laser(
        angle: 0,
        sweep: 22.5,
        range: 0,
        numberOfBeams: 50,
      ),
    );
    await level.add(laser);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (active) {
      if (input.hasInput) {
        body.linearVelocity = input.direction * Constants.AGENT_SPEED;
      } else {
        body.linearVelocity = Vector2.zero();
      }
    }

    if (active && Debug.hasAgentVision) {
      laser.show(
        source: body.position,
        angle: body.angle,
        rayCasting: rayCasting,
      );
    } else {
      laser.hide();
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.dynamic,
    group: CollisionGroup.AGENT,
    angle: 0,
  );
}

class AgentSpriteComponent extends PositionComponent {
  final Agent agent;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
  );

  AgentSpriteComponent({
    required super.position,
    required this.agent,
  }) : super(size: Vector2(10, 10));

  @override
  Future onLoad() async {
    await super.onLoad();

    paintFill.color = Colors.white;
    // Constants.AGENT_COLORS[agent.id]!;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      Offset(position.x, position.y),
      size.x / 2,
      paintFill,
    );
  }
}
