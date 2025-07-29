import 'dart:async';
import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/vision_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class SoldierComponent extends BodyComponent<GameComponent> {
  late final RayCasting rayCasting;
  final Vector2 initialPosition;
  final Vector2 size;
  final Soldier soldier;
  late final VisionComponent vision;

  SoldierComponent({
    required this.initialPosition,
    required this.size,
    required this.soldier,
  }) : super(priority: Priority.soldier.value);

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);

    await add(
      SoldierSpriteComponent(
        soldier: soldier,
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
    angle: soldier.angle,
    group: CollisionGroup.SOLDIER,
  );

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();

    for (final Behavior behavior in soldier.behaviors) {
      behavior.update(body, dt);
    }

    vision.show(
      source: body.position,
      angle: body.angle,
      rayCasting: rayCasting,
    );
  }
}

class SoldierSpriteComponent extends PositionComponent {
  final Soldier soldier;
  late final SpriteAnimationGroupComponent<SoldierMovingState> spriteAnimation;
  SoldierMovingState movingState = SoldierMovingState.idle_right;

  SoldierSpriteComponent({
    required this.soldier,
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
      current: movingState,
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
}

enum SoldierMovingState {
  idle_up(0, 0 * degrees2Radians),
  idle_up_right(45, 45 * degrees2Radians),
  idle_right(90, 90 * degrees2Radians),
  idle_down_right(135, 135 * degrees2Radians),
  idle_down(180, 180 * degrees2Radians),
  idle_down_left(225, 225 * degrees2Radians),
  idle_left(270, 270 * degrees2Radians),
  idle_up_left(315, 315 * degrees2Radians);

  final double angle;
  final double radians;

  const SoldierMovingState(this.angle, this.radians);

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
