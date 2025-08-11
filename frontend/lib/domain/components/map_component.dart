import 'package:commandos/domain/components/door_closed_component.dart';
import 'package:commandos/domain/components/door_opened_component.dart';
import 'package:commandos/domain/components/wall_component.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/domain/types/door_status.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';

class MapComponent extends SpriteComponent {
  final List<Wall> walls;
  final List<Door> doors;

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
  }
}
