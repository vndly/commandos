import 'dart:async';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/components/vision_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class SoldierComponent extends EnemyComponent {
  final Soldier soldier;
  late final VisionComponent vision;
  SoldierMovingState movingState = SoldierMovingState.idle_right;

  SoldierComponent({
    required super.initialPosition,
    required super.size,
    required this.soldier,
  }) : super(priority: Priority.soldier.value, facingAngle: soldier.angle);

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

    vision = VisionComponent(
      sweep: soldier.sweep,
      range: soldier.range,
    );
    await world.add(vision);
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

    movingState = _getMovingState(degrees(facingAngle));

    for (final Behavior behavior in soldier.behaviors) {
      behavior.update(this, dt);
    }

    vision.show(
      source: body.position,
      angle: facingAngle,
      rayCasting: rayCasting,
    );
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
  }) : super(anchor: Anchor.center);

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
