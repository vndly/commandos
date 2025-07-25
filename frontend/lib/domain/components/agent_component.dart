import 'dart:async';
import 'dart:ui';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/canvas_extension.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
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
    movement = AgentMovement(
      agent: this,
      initialPosition: initialPosition,
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
    final SpriteAnimation idleUp = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_IDLE_UP,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    final SpriteAnimation idleDown = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_IDLE_DOWN,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    final SpriteAnimation idleLeft = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_IDLE_LEFT,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    final SpriteAnimation idleRight = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_IDLE_RIGHT,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    final SpriteAnimation walkingUp = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_UP,
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    final SpriteAnimation walkingDown = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_DOWN,
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    final SpriteAnimation walkingLeft = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_LEFT,
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    final SpriteAnimation walkingRight = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_RIGHT,
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );

    spriteAnimation = SpriteAnimationGroupComponent<AgentMovingState>(
      animations: {
        AgentMovingState.idle_up: idleUp,
        AgentMovingState.idle_down: idleDown,
        AgentMovingState.idle_left: idleLeft,
        AgentMovingState.idle_right: idleRight,
        AgentMovingState.walking_up: walkingUp,
        AgentMovingState.walking_down: walkingDown,
        AgentMovingState.walking_left: walkingLeft,
        AgentMovingState.walking_right: walkingRight,
      },
      current: movement.movingState,
      position: Vector2(0, 0),
      size: size,
    );

    add(spriteAnimation);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    spriteAnimation.current = movement.movingState;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: agent.id,
      position: Vector2(size.x / 2, size.y / 2.2),
      size: size.x / 3,
    );
  }
}

enum AgentMovingState {
  idle_up,
  idle_down,
  idle_left,
  idle_right,
  walking_up,
  walking_down,
  walking_left,
  walking_right,
}

class AgentMovement {
  final AgentComponent agent;
  AgentMovingState movingState = AgentMovingState.idle_right;
  bool isMoving = false;

  AgentMovement({
    required this.agent,
    required Vector2 initialPosition,
  });

  void update(Input input) {
    if (input.hasInput && !isMoving) {
      nextNode = currentNode.nodeAt(input.direction);

      if (nextNode != null) {
        isMoving = true;
        final Vector2 velocity = input.direction * Constants.AGENT_SPEED;
        agent.body.linearVelocity = velocity;

        if (input.direction.y < 0) {
          movingState = AgentMovingState.walking_up;
        } else if (input.direction.y > 0) {
          movingState = AgentMovingState.walking_down;
        } else if (input.direction.x < 0) {
          movingState = AgentMovingState.walking_left;
        } else if (input.direction.x > 0) {
          movingState = AgentMovingState.walking_right;
        }
      }
    }

    if (isMoving) {
      final Vector2 currentPosition = agent.body.position;
      final Vector2 targetPosition = nextNode!.position;
      final Vector2 toTarget = targetPosition - currentPosition;

      if (toTarget.length < 0.1) {
        agent.body.linearVelocity = Vector2.zero();
        agent.body.setTransform(targetPosition, agent.body.angle);
        isMoving = false;
        currentNode = nextNode!;
        nextNode = null;

        final Node? conectionTo = getConnectionTo(currentNode);

        if (conectionTo != null) {
          currentNode = conectionTo;
          agent.body.setTransform(conectionTo.position, agent.body.angle);
        }
      }
    } else {
      if (movingState == AgentMovingState.walking_up) {
        movingState = AgentMovingState.idle_up;
      } else if (movingState == AgentMovingState.walking_down) {
        movingState = AgentMovingState.idle_down;
      } else if (movingState == AgentMovingState.walking_left) {
        movingState = AgentMovingState.idle_left;
      } else if (movingState == AgentMovingState.walking_right) {
        movingState = AgentMovingState.idle_right;
      }
    }
  }

  Node? getConnectionTo(Node node) {
    for (final Connection connection in connections) {
      if (connection.a == node) {
        return connection.b;
      } else if (connection.b == node) {
        return connection.a;
      }
    }

    return null;
  }
}
