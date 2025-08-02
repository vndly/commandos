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
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class SoldierComponent extends EnemyComponent {
  final Soldier soldier;
  final List<AgentComponent> agents;
  late final VisionComponent vision;
  SoldierMovingState movingState = SoldierMovingState.idle_right;
  final List<DebugVisionComponent> debugVision = [];

  SoldierComponent({
    required super.position,
    required this.soldier,
    required this.agents,
  }) : super(
         size: Vector2(28, 28),
         headAngle: soldier.headAngle,
         bodyAngle: soldier.bodyAngle,
         priority: Priority.soldier.value,
       );

  bool inFieldOfView(double angle) {
    final double minAngle = headAngle - soldier.sweep;
    final double maxAngle = headAngle + soldier.sweep;

    return angle >= minAngle && angle <= maxAngle;
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    await add(
      SoldierSpriteComponent(
        soldier: soldier,
        soldierComponent: this,
        size: size,
      ),
    );

    for (final AgentComponent agent in agents) {
      final DebugVisionComponent debugVisionComponent = DebugVisionComponent(
        soldier: this,
        agent: agent,
      );
      debugVision.add(debugVisionComponent);
      await level.add(debugVisionComponent);
    }

    vision = VisionComponent(
      sweep: soldier.sweep,
      range: soldier.range,
    );
    await level.add(vision);
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size / 4),
    center: initialPosition,
    bodyType: BodyType.kinematic,
    angle: 0,
    group: CollisionGroup.SOLDIER,
  );

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();

    movingState = _getMovingState(degrees(bodyAngle));

    for (final Behavior behavior in soldier.behaviors) {
      behavior.update(this, dt);
    }

    vision.show(
      source: body.position,
      angle: headAngle,
      rayCasting: rayCasting,
    );

    for (final DebugVisionComponent debugVision in debugVision) {
      debugVision.show(
        source: body.position,
        rayCasting: rayCasting,
      );
    }
  }

  SoldierMovingState _getMovingState(double angle) {
    final double positiveAngle = angle < 0 ? angle + 360 : angle;

    for (final SoldierMovingState state in SoldierMovingState.values) {
      if (positiveAngle >= state.angleMin && positiveAngle < state.angleMax) {
        return state;
      }
    }

    return movingState;
  }
}

class SoldierSpriteComponent extends PositionComponent {
  final Soldier soldier;
  final SoldierComponent soldierComponent;
  late final SpriteAnimationGroupComponent<SoldierMovingState> spriteAnimation;

  SoldierSpriteComponent({
    required this.soldier,
    required this.soldierComponent,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.soldier.value,
       );

  @override
  FutureOr onLoad() async {
    spriteAnimation = SpriteAnimationGroupComponent<SoldierMovingState>(
      animations: {
        SoldierMovingState.idle_up: await _idleAnimation(0),
        SoldierMovingState.idle_up_right: await _idleAnimation(1),
        SoldierMovingState.idle_right: await _idleAnimation(2),
        SoldierMovingState.idle_down_right: await _idleAnimation(3),
        SoldierMovingState.idle_down: await _idleAnimation(4),
        SoldierMovingState.idle_down_left: await _idleAnimation(5),
        SoldierMovingState.idle_left: await _idleAnimation(6),
        SoldierMovingState.idle_up_left: await _idleAnimation(7),
      },
      current: soldierComponent.movingState,
      position: Vector2(0, 0),
      size: size,
    );

    add(spriteAnimation);

    return super.onLoad();
  }

  Future<SpriteAnimation> _idleAnimation(int range) => SpriteAnimation.load(
    Assets.IMAGES_ANIMATIONS_SOLDIERS_IDLE,
    SpriteAnimationData.range(
      start: range,
      end: range,
      amount: 8,
      stepTimes: [1],
      textureSize: Vector2(36, 36),
    ),
  );

  @override
  void update(double dt) {
    super.update(dt);

    spriteAnimation.current = soldierComponent.movingState;
  }
}

enum SoldierMovingState {
  idle_up(247.5, 292.5),
  idle_up_right(292.5, 337.5),
  idle_right(337.5, 22.5),
  idle_down_right(22.5, 67.5),
  idle_down(67.5, 112.5),
  idle_down_left(112.5, 157.5),
  idle_left(157.5, 202.5),
  idle_up_left(202.5, 247.5);

  final double angleMin;
  final double angleMax;

  const SoldierMovingState(this.angleMin, this.angleMax);

  bool get isIdle =>
      this == SoldierMovingState.idle_up ||
      this == SoldierMovingState.idle_up_right ||
      this == SoldierMovingState.idle_right ||
      this == SoldierMovingState.idle_down_right ||
      this == SoldierMovingState.idle_down ||
      this == SoldierMovingState.idle_down_left ||
      this == SoldierMovingState.idle_left ||
      this == SoldierMovingState.idle_up_left;
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
