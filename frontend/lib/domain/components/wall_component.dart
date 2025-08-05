import 'dart:ui';

import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class WallComponent extends BodyComponent<GameComponent> {
  final Wall wall;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.stroke,
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

    canvas.drawPath();
  }*/

  @override
  Body createBody() => getBodyFromAbsolutePosition(
    vertices: wall.vertices,
    bodyType: BodyType.static,
    group: CollisionGroup.WALL,
    angle: 0,
  );
}
