import 'package:commandos/domain/components/wall_component.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:flame/components.dart';

class MapComponent extends PositionComponent {
  final List<Wall> walls;

  MapComponent({
    required this.walls,
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
  }
}
