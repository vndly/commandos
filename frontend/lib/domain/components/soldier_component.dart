import 'dart:async';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/components/vision_component.dart';
import 'package:commandos/domain/models/beam.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/extensions/vector2_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class SoldierComponent extends EnemyComponent {
  final Soldier soldier;
  final List<AgentComponent> agents;
  late final VisionComponent vision;
  final List<DebugVisionComponent> debugVision = [];

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

    for (final AgentComponent agent in agents) {
      final DebugVisionComponent debugVisionComponent = DebugVisionComponent(
        soldier: this,
        agent: agent,
      );
      debugVision.add(debugVisionComponent);
      await level.add(debugVisionComponent); // TODO(momo): don't add to level
    }

    vision = VisionComponent(
      sweep: soldier.sweep,
      range: soldier.range,
    );
    await level.add(vision); // TODO(momo): don't add to level
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

    for (final Behavior behavior in soldier.behaviors) {
      behavior.update(this, dt);
    }

    vision.show(
      source: body.position,
      angle: body.angle,
      rayCasting: rayCasting,
    );

    for (final DebugVisionComponent debugVision in debugVision) {
      debugVision.show(
        source: body.position,
        rayCasting: rayCasting,
      );
    }
  }
}

class SoldierSpriteComponent extends PositionComponent {
  final Soldier soldier;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.red,
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

class DebugVisionComponent extends Component {
  final SoldierComponent soldier;
  final AgentComponent agent;
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.DETECTED,
    strokeWidth: 0.5,
  );
  late final Beam beam;

  DebugVisionComponent({
    required this.soldier,
    required this.agent,
  }) {
    priority = Priority.vision.value;

    beam = Beam(
      start: Vector2.zero(),
      end: Vector2.zero(),
      angle: 0,
    );
  }

  void show({
    required Vector2 source,
    required RayCasting rayCasting,
  }) {
    final RayCastingResult result = rayCasting.test(
      source: source,
      angle: source.angle(agent.body.position),
      gap: 0,
      length: 1000,
    );

    if (isInFieldOfView(result: result)) {
      beam.update(result);
    } else {
      hide();
    }
  }

  void hide() {
    beam.start = Vector2.zero();
    beam.end = Vector2.zero();
  }

  bool isInFieldOfView({
    required RayCastingResult result,
  }) {
    return (result.object is AgentComponent) &&
        soldier.body.position.distanceTo(result.end) <= soldier.soldier.range &&
        soldier.inFieldOfView(result.angle);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawLine(beam.start.toOffset(), beam.end.toOffset(), paint);
  }
}
