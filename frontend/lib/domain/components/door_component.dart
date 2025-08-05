import 'dart:async';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/audio.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class DoorComponent extends PhysicalComponent {
  DoorStatus status = DoorStatus.closed;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
  );

  DoorComponent({
    required super.size,
    required super.position,
  });

  @override
  Future onLoad() async {
    await super.onLoad();

    await level.add(
      DoorDetector(
        doorComponent: this,
        size: size,
        position: position,
        priority: 0,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    switch (status) {
      case DoorStatus.closed:
        paintFill.color = Colors.red;
      case DoorStatus.open:
        paintFill.color = Colors.green;
    }

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paintFill,
    );
  }

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(-size.x / 2, 0),
      Vector2(size.x / 2, 0),
      Vector2(size.x / 2, size.y / 2),
      Vector2(-size.x / 2, size.y / 2),
    ]);

    return getBodyFromRelativePosition(
      shape: shape,
      center: initialPosition,
      bodyType: BodyType.kinematic,
      group: CollisionGroup.DOOR,
      angle: 0,
    );
  }

  void onAgentEnter() {
    if (status == DoorStatus.closed) {
      status = DoorStatus.open;
      Audio.get.playSound(Audio.DOOR);
    }
  }

  void onAgentExit() {
    if (status == DoorStatus.open) {
      status = DoorStatus.closed;
      Audio.get.playSound(Audio.DOOR);
    }
  }
}

class DoorDetector extends PhysicalComponent with ContactCallbacks {
  final DoorComponent doorComponent;

  DoorDetector({
    required this.doorComponent,
    required super.size,
    required super.position,
    required super.priority,
  });

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();
    shape.set([
      Vector2(-size.x / 2, 0),
      Vector2(size.x / 2, 0),
      Vector2(size.x / 2, size.y / 2),
      Vector2(-size.x / 2, size.y / 2),
    ]);

    return getBodyFromRelativePosition(
      shape: shape,
      center: initialPosition,
      bodyType: BodyType.static,
      group: CollisionGroup.DOOR_DETECTOR,
      angle: 0,
    );
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      doorComponent.onAgentEnter();
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      doorComponent.onAgentExit();
    }
  }
}

enum DoorStatus {
  closed,
  open,
}
