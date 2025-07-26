import 'dart:async';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class AgentComponent extends BodyComponent<GameComponent> {
  final Vector2 initialPosition;
  final Vector2 size;
  final Vector2 velocity = Vector2.zero();
  final Input input;
  final Agent agent;
  late final AgentMovement movement;
  bool active;

  AgentComponent({
    required this.initialPosition,
    required this.size,
    required this.input,
    required this.agent,
    required this.active,
  }) {
    priority = Priority.agent.value;
    movement = AgentMovement(
      agent: this,
    );
  }

  @override
  Future onLoad() async {
    await super.onLoad();
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

    checkDebug();

    if (active) {
      movement.update(input);
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size * 0.3),
    center: initialPosition,
    bodyType: BodyType.dynamic,
    group: CollisionGroup.AGENT,
    angle: agent.angle,
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
    final PaintDecorator decorator2 = PaintDecorator.tint(
      Constants.AGENT_COLORS[agent.id]!,
    );
    decorator.addLast(decorator2);

    spriteAnimation = SpriteAnimationGroupComponent<AgentMovingState>(
      animations: {
        AgentMovingState.idle_up: await _idleAnimation(0),
        AgentMovingState.idle_up_right: await _idleAnimation(1),
        AgentMovingState.idle_right: await _idleAnimation(2),
        AgentMovingState.idle_down_right: await _idleAnimation(3),
        AgentMovingState.idle_down: await _idleAnimation(4),
        AgentMovingState.idle_down_left: await _idleAnimation(5),
        AgentMovingState.idle_left: await _idleAnimation(6),
        AgentMovingState.idle_up_left: await _idleAnimation(7),
        AgentMovingState.walking_up: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_UP,
        ),
        AgentMovingState.walking_up_right: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_UP_RIGHT,
        ),
        AgentMovingState.walking_right: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_RIGHT,
        ),
        AgentMovingState.walking_down_right: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_DOWN_RIGHT,
        ),
        AgentMovingState.walking_down: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_DOWN,
        ),
        AgentMovingState.walking_down_left: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_UP,
        ),
        AgentMovingState.walking_left: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_UP,
        ),
        AgentMovingState.walking_up_left: await _walkingAnimation(
          Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_UP,
        ),
      },
      current: movement.movingState,
      position: Vector2(0, 0),
      size: size,
    );

    add(spriteAnimation);

    return super.onLoad();
  }

  Future<SpriteAnimation> _idleAnimation(int range) => SpriteAnimation.load(
    Assets.IMAGES_ANIMATIONS_AGENTS_IDLE,
    SpriteAnimationData.range(
      start: range,
      end: range,
      amount: 8,
      stepTimes: [1],
      textureSize: Vector2(36, 36),
    ),
  );

  Future<SpriteAnimation> _walkingAnimation(String path) =>
      SpriteAnimation.load(
        path,
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(36, 36),
        ),
      );

  @override
  void update(double dt) {
    super.update(dt);

    spriteAnimation.current = movement.movingState;
  }
}

enum AgentMovingState {
  idle_up,
  idle_up_right,
  idle_right,
  idle_down_right,
  idle_down,
  idle_down_left,
  idle_left,
  idle_up_left,
  walking_up,
  walking_up_right,
  walking_right,
  walking_down_right,
  walking_down,
  walking_down_left,
  walking_left,
  walking_up_left;

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
