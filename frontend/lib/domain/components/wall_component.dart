import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class WallComponent extends PhysicalComponent {
  final Wall wall;

  WallComponent({required this.wall})
    : super(
        position: wall.position,
        size: wall.size,
        priority: Priority.wall.value,
      );

  @override
  Future onLoad() async {
    await super.onLoad();

    add(
      WallSpriteComponent(
        wall: wall,
        position: size / 2,
        size: size,
      ),
    );
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapePolygon(wall.vertices),
    center: wall.position,
    bodyType: BodyType.static,
    group: CollisionGroup.WALL,
    angle: 0,
  );
}

class WallSpriteComponent extends PositionComponent {
  final Wall wall;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.stroke,
    color: Colors.white,
    strokeWidth: 0.5,
  );

  WallSpriteComponent({
    required this.wall,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawPath(wall.path, paintFill);
  }
}
