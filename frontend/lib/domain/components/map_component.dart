import 'package:commandos/domain/components/door_closed_component.dart';
import 'package:commandos/domain/components/door_opened_component.dart';
import 'package:commandos/domain/components/wall_component.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/domain/types/door_status.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MapComponent extends PositionComponent {
  final List<Wall> walls;
  final List<Door> doors;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MAP_BACKGROUND,
  );

  MapComponent({
    required this.walls,
    required this.doors,
    required super.size,
  }) : super(
         position: Vector2.zero(),
         anchor: Anchor.topLeft,
         priority: Priority.map.value,
       );

  @override
  Future onLoad() async {
    await super.onLoad();

    for (final Wall wall in walls) {
      await add(
        WallComponent(wall: wall),
      );
    }

    for (final Door door in doors) {
      if (door.status == DoorStatus.closed) {
        await add(
          DoorClosedComponent(door: door),
        );
      } else if (door.status == DoorStatus.opened) {
        await add(
          DoorOpenedComponent(door: door),
        );
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.x, size.y),
      paintFill,
    );
  }
}
