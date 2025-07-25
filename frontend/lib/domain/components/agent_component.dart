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
    /*final SpriteAnimation idleDown = await SpriteAnimation.load(
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
    );*/
    final SpriteAnimation walkingUp = await SpriteAnimation.load(
      Assets.IMAGES_ANIMATIONS_AGENTS_WALKING_UP,
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(128, 128),
      ),
    );
    /*final SpriteAnimation walkingDown = await SpriteAnimation.load(
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
    );*/

    spriteAnimation = SpriteAnimationGroupComponent<AgentMovingState>(
      animations: {
        AgentMovingState.idle: idleUp,
        AgentMovingState.walking: walkingUp,
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
  idle,
  walking,
}

class AgentMovement {
  final AgentComponent agent;
  AgentMovingState movingState = AgentMovingState.idle;

  AgentMovement({
    required this.agent,
  });

  void update(Input input) {
    if (input.hasInput) {
      movingState = AgentMovingState.walking;
      final Vector2 velocity = input.direction * Constants.AGENT_SPEED;
      agent.body.linearVelocity = velocity;
    } else {
      movingState = AgentMovingState.idle;
      agent.body.linearVelocity = Vector2.zero();
    }
  }
}
