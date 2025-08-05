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
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class AgentComponent extends PhysicalComponent {
  final Vector2 velocity = Vector2.zero();
  final Input input;
  final Agent agent;
  late final AgentMovement movement;
  late final LaserComponent laser;
  late final RayCasting rayCasting;
  bool active;

  AgentComponent({
    required super.position,
    required this.input,
    required this.agent,
    required this.active,
  }) : super(size: Vector2(28, 28), priority: Priority.agent.value) {
    movement = AgentMovement(agent: this);
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);

    laser = LaserComponent(
      laser: const Laser(
        angle: 0,
        sweep: 22.5,
        range: 0,
        numberOfBeams: 50,
      ),
    );
    await level.add(laser);

    await add(
      AgentSpriteComponent(
        agent: agent,
        movement: movement,
        size: size,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (active) {
      movement.update(input);
    }

    if (active && Debug.hasAgentVision) {
      laser.show(
        source: body.position,
        angle: movement.movingState.radians,
        rayCasting: rayCasting,
      );
    } else {
      laser.hide();
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size * 0.35),
    center: initialPosition,
    bodyType: BodyType.dynamic,
    group: CollisionGroup.AGENT,
    angle: 0,
  );
}

class AgentSpriteComponent extends PositionComponent {
  final Agent agent;
  final AgentMovement movement;
  late final SpriteAnimationGroupComponent<AgentMovingState> spriteAnimation;

  AgentSpriteComponent({
    required this.agent,
    required this.movement,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    decorator.addLast(
      PaintDecorator.tint(
        Constants.AGENT_COLORS[agent.id]!,
      ),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    spriteAnimation.current = movement.movingState;
  }
}

enum AgentMovingState {
  idle_up(0, 0 * degrees2Radians),
  idle_up_right(45, 45 * degrees2Radians),
  idle_right(90, 90 * degrees2Radians),
  idle_down_right(135, 135 * degrees2Radians),
  idle_down(180, 180 * degrees2Radians),
  idle_down_left(225, 225 * degrees2Radians),
  idle_left(270, 270 * degrees2Radians),
  idle_up_left(315, 315 * degrees2Radians),
  walking_up(0, 0 * degrees2Radians),
  walking_up_right(45, 45 * degrees2Radians),
  walking_right(90, 90 * degrees2Radians),
  walking_down_right(135, 135 * degrees2Radians),
  walking_down(180, 180 * degrees2Radians),
  walking_down_left(225, 225 * degrees2Radians),
  walking_left(270, 270 * degrees2Radians),
  walking_up_left(315, 315 * degrees2Radians);

  final double angle;
  final double radians;

  const AgentMovingState(this.angle, this.radians);

  bool get isIdle =>
      this == AgentMovingState.idle_up ||
      this == AgentMovingState.idle_up_right ||
      this == AgentMovingState.idle_right ||
      this == AgentMovingState.idle_down_right ||
      this == AgentMovingState.idle_down ||
      this == AgentMovingState.idle_down_left ||
      this == AgentMovingState.idle_left ||
      this == AgentMovingState.idle_up_left;
}

class AgentMovement {
  final AgentComponent agent;
  AgentMovingState movingState = AgentMovingState.idle_right;

  AgentMovement({
    required this.agent,
  });

  void update(Input input) {
    if (input.hasInput) {
      movingState = _walkingSate(input.direction);
      agent.body.linearVelocity = input.direction * Constants.AGENT_SPEED;
    } else if (!movingState.isIdle) {
      movingState = _idleState(movingState);
      agent.body.linearVelocity = Vector2.zero();
    }
  }

  AgentMovingState _walkingSate(Vector2 direction) {
    if (direction.x > 0 && direction.y < 0) {
      return AgentMovingState.walking_up_right;
    } else if (direction.x > 0 && direction.y > 0) {
      return AgentMovingState.walking_down_right;
    } else if (direction.x < 0 && direction.y < 0) {
      return AgentMovingState.walking_up_left;
    } else if (direction.x < 0 && direction.y > 0) {
      return AgentMovingState.walking_down_left;
    } else if (direction.x > 0) {
      return AgentMovingState.walking_right;
    } else if (direction.x < 0) {
      return AgentMovingState.walking_left;
    } else if (direction.y > 0) {
      return AgentMovingState.walking_down;
    } else if (direction.y < 0) {
      return AgentMovingState.walking_up;
    } else {
      return movingState;
    }
  }

  AgentMovingState _idleState(AgentMovingState current) {
    switch (movingState) {
      case AgentMovingState.walking_up:
        return AgentMovingState.idle_up;

      case AgentMovingState.walking_up_right:
        return AgentMovingState.idle_up_right;

      case AgentMovingState.walking_right:
        return AgentMovingState.idle_right;

      case AgentMovingState.walking_down_right:
        return AgentMovingState.idle_down_right;

      case AgentMovingState.walking_down:
        return AgentMovingState.idle_down;

      case AgentMovingState.walking_down_left:
        return AgentMovingState.idle_down_left;

      case AgentMovingState.walking_left:
        return AgentMovingState.idle_left;

      case AgentMovingState.walking_up_left:
        return AgentMovingState.idle_up_left;

      default:
        return current;
    }
  }
}
