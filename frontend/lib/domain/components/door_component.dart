import 'dart:async';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/audio.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class DoorComponent extends PhysicalComponent {
  final Door door;
  late DoorStatus status;

  DoorComponent({
    required this.door,
  }) : super(
         position: door.position,
         size: door.size,
         priority: Priority.door.value,
       ) {
    status = door.status;
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    await level.add(
      DoorDetector(
        doorComponent: this,
        position: position,
        size: size,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (status == DoorStatus.open) {
      body.setTransform(Vector2(0, 0), angle);
    }
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeSquare(door.size),
    center: initialPosition,
    bodyType: BodyType.static,
    group: CollisionGroup.DOOR,
    angle: 0,
  );

  void onAgentEnter() {
    if (status == DoorStatus.closed) {
      status = DoorStatus.open;
      Audio.get.playSound(Audio.DOOR);
    }
  }

  void onAgentExit() {
    /*if (status == DoorStatus.open) {
      status = DoorStatus.closed;
      Audio.get.playSound(Audio.DOOR);
    }*/
  }
}

class DoorDetector extends PhysicalComponent with ContactCallbacks {
  final DoorComponent doorComponent;

  DoorDetector({
    required this.doorComponent,
    required super.position,
    required super.size,
  });

  @override
  Future onLoad() async {
    await super.onLoad();

    add(
      DoorSpriteComponent(
        doorComponent: doorComponent,
        position: size / 2,
        size: size,
      ),
    );
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeSquare(doorComponent.door.size),
    center: initialPosition,
    bodyType: BodyType.static,
    group: CollisionGroup.DOOR_DETECTOR,
    angle: 0,
  );

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

class DoorSpriteComponent extends PositionComponent {
  final DoorComponent doorComponent;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.red,
  );

  DoorSpriteComponent({
    required this.doorComponent,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    switch (doorComponent.status) {
      case DoorStatus.closed:
        paintFill.color = Colors.red;
      case DoorStatus.open:
        paintFill.color = Colors.green;
    }

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: doorComponent.door.size.x,
        height: doorComponent.door.size.y,
      ),
      paintFill,
    );
  }
}

enum DoorStatus {
  closed,
  open,
}
