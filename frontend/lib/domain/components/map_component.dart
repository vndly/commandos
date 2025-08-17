import 'dart:ui';
import 'package:commandos/app/debug.dart';
import 'package:commandos/domain/components/door_closed_component.dart';
import 'package:commandos/domain/components/door_opened_component.dart';
import 'package:commandos/domain/components/wall_component.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/domain/types/door_status.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';

class MapComponent extends SpriteComponent {
  final Nodes nodes;
  final List<Wall> walls;
  final List<Door> doors;

  MapComponent({
    required this.nodes,
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

    sprite = await Sprite.load(Assets.IMAGES_MAPS_GYM);

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

    await add(PathsComponent(nodes: nodes));
  }
}

class PathsComponent extends PositionComponent {
  final Paint paint = Palette.paint(
    style: PaintingStyle.fill,
    color: const Color(0xffff0000),
  );
  final Nodes nodes;

  PathsComponent({required this.nodes})
    : super(position: Vector2.zero(), anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    if (Debug.hasNodeDebug) {
      for (final Node node in nodes) {
        final Vector2 position = node.position;
        canvas.drawCircle(position.toOffset(), 0.5, paint);
      }
    }

    super.render(canvas);
  }
}
