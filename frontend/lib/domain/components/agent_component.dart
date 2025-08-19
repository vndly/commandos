import 'dart:async';
import 'dart:math';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/portal.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/body_extension.dart';
import 'package:commandos/presentation/audio/audio.dart';
import 'package:commandos/presentation/audio/sound.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class AgentComponent extends PhysicalComponent {
  final Vector2 velocity = Vector2.zero();
  final Input input;
  final Agent agent;
  final Nodes nodes;
  final List<Portal> portals;
  late final AgentMovement movement;
  final List<Vector2> detectionPoints = [];
  bool active;

  AgentComponent({
    required this.input,
    required this.agent,
    required this.nodes,
    required this.portals,
    required this.active,
  }) : super(
         position: agent.position,
         size: Vector2(10, 10),
         priority: Priority.agent.value,
       ) {
    movement = AgentMovement(
      agent: this,
      nodes: nodes,
      portals: portals,
      initialPosition: initialPosition,
    );
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    add(
      AgentSpriteComponent(
        agent: agent,
        position: size / 2,
        size: size,
      ),
    );

    const int numberOfPoints = 6;
    const double angleStep = 360 / numberOfPoints;

    for (int i = 0; i < numberOfPoints; i++) {
      final double angle = radians(i * angleStep);
      final Vector2 point = Vector2(cos(angle), sin(angle)) * (size.x / 2);
      detectionPoints.add(point);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (active) {
      movement.update(input);
    }
  }

  void onInteract() {
    // TODO(momo): interact with objects
    if (movement.objectFacing != null) {
      print('Interacting with: ${movement.objectFacing}');
    } else {
      print('No object to interact with');
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size),
    center: initialPosition,
    bodyType: BodyType.dynamic,
    group: CollisionGroup.AGENT,
    angle: radians(movement.orientation.angle),
  );
}

class AgentSpriteComponent extends PositionComponent {
  final Agent agent;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
  );
  final Paint paintOrientation = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 0.5,
    color: Palette.ORIENTATION,
  );

  AgentSpriteComponent({
    required this.agent,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  Future onLoad() async {
    await super.onLoad();

    paintFill.color = Constants.AGENT_COLORS[agent.id]!;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      Offset.zero,
      size.x / 2,
      paintFill,
    );

    canvas.drawLine(
      Offset.zero,
      Offset(0, -size.y / 2),
      paintOrientation,
    );
  }
}

class AgentMovement {
  final AgentComponent agent;
  final Nodes nodes;
  final List<Portal> portals;
  late Node currentNode;
  AgentOrientation orientation = AgentOrientation.right;
  bool isMoving = false;
  Node? nextNode;
  Object? objectFacing;

  AgentMovement({
    required this.agent,
    required this.nodes,
    required this.portals,
    required Vector2 initialPosition,
  }) {
    currentNode = nodes.nodeAt(initialPosition);
  }

  void update(Input input) {
    if (input.hasInput && !isMoving) {
      final Vector2 direction = input.direction;
      objectFacing = currentNode.objectAt(direction);
      orientation = AgentOrientation.fromDirection(direction);
      agent.body.setAngle(orientation.angle);

      if (canTraverseObject(objectFacing)) {
        nextNode = currentNode.nodeAt(direction);

        if (nextNode != null) {
          isMoving = true;
          final Vector2 velocity = input.direction * Constants.AGENT_SPEED;
          agent.body.linearVelocity = velocity;
        }
      }
    }

    if (isMoving) {
      Audio.get.playSound(Sound.STEP);
      final Vector2 currentPosition = agent.body.position;
      final Vector2 targetPosition = nextNode!.position;
      final Vector2 toTarget = targetPosition - currentPosition;

      if (toTarget.length < 0.1) {
        agent.body.linearVelocity = Vector2.zero();
        agent.body.setPosition(targetPosition);
        isMoving = false;
        currentNode = nextNode!;
        nextNode = null;

        final Node? teleportTo = getTeleportTo(currentNode);

        if (teleportTo != null) {
          currentNode = teleportTo;
          agent.body.setPosition(teleportTo.position);
        }
      }
    } else {
      Audio.get.stopSound(Sound.STEP);
    }
  }

  bool canTraverseObject(Object? object) {
    if (object == null) {
      return true;
    } else {
      return false;
    }
  }

  Node? getTeleportTo(Node node) {
    for (final Portal portal in portals) {
      if (portal.a == node) {
        return portal.b;
      } else if (portal.b == node) {
        return portal.a;
      }
    }

    return null;
  }
}

enum AgentOrientation {
  up,
  down,
  left,
  right;

  double get angle {
    switch (this) {
      case AgentOrientation.up:
        return 0;
      case AgentOrientation.down:
        return 180;
      case AgentOrientation.left:
        return 270;
      case AgentOrientation.right:
        return 90;
    }
  }

  static AgentOrientation fromDirection(Vector2 direction) {
    if (direction.x > 0) {
      return AgentOrientation.right;
    } else if (direction.x < 0) {
      return AgentOrientation.left;
    } else if (direction.y > 0) {
      return AgentOrientation.down;
    } else if (direction.y < 0) {
      return AgentOrientation.up;
    } else {
      throw ArgumentError('Invalid direction: $direction');
    }
  }
}
