import 'dart:async';
import 'dart:ui';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/domain/models/nodes.dart';
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
  final Nodes nodes;
  final List<Connection> connections;
  late final AgentMovement movement;
  bool active;

  AgentComponent({
    required this.initialPosition,
    required this.size,
    required this.input,
    required this.agent,
    required this.nodes,
    required this.connections,
    required this.active,
  }) {
    movement = AgentMovement(
      agent: this,
      nodes: nodes,
      connections: connections,
      initialPosition: initialPosition,
    );
  }

  @override
  Future onLoad() async {
    await super.onLoad();
    setup();
    await add(
      AgentSpriteComponent(
        agent: agent,
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
  }

  @override
  Body createBody() => getBody(
    vertices: [
      Vector2(0, -size.y / 2),
      Vector2(size.x / 2, 0),
      Vector2(0, size.y / 2),
      Vector2(-size.x / 2, 0),
    ],
    initialPosition: initialPosition,
    bodyType: BodyType.kinematic,
  );
}

class AgentSpriteComponent extends SpriteComponent {
  final Agent agent;

  AgentSpriteComponent({required this.agent, required super.size})
    : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_AGENTS_AGENT);

    return super.onLoad();
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

class AgentMovement {
  final AgentComponent agent;
  final Nodes nodes;
  final List<Connection> connections;
  late Node currentNode;
  bool isMoving = false;
  Node? nextNode;

  AgentMovement({
    required this.agent,
    required this.nodes,
    required this.connections,
    required Vector2 initialPosition,
  }) {
    currentNode = nodes.nodeAt(initialPosition);
  }

  void update(Input input) {
    if (input.hasInput && !isMoving) {
      nextNode = currentNode.nodeAt(input.direction);

      if (nextNode != null) {
        isMoving = true;
        final Vector2 velocity = input.direction * Constants.AGENT_SPEED;
        agent.body.linearVelocity = velocity;
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
