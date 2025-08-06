import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class WallComponent extends BodyComponent<GameComponent> {
  final Wall wall;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.stroke,
    color: Colors.white,
    strokeWidth: 0.5,
  );

  WallComponent({required this.wall});

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();
  }

  /*@override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawPath(canvas.path(wall.vertices), paintFill);
  }*/

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapePolygon(wall.vertices),
    center: wall.position,
    bodyType: BodyType.static,
    group: CollisionGroup.WALL,
    angle: 0,
  );
}
