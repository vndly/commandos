import 'dart:async';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:cavedash/domain/components/map_component.dart';
import 'package:cavedash/domain/components/wall_component.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  final Grid grid;
  late final CharacterComponent characterComponent;

  LevelComponent({
    required this.grid,
  });

  @override
  FutureOr onLoad() {
    add(MapBackgroundComponent(
      grid: grid,
    ));

    /*add(GridComponent(
      grid: grid,
    ));*/

    characterComponent = CharacterComponent(
      size: Vector2(4, 4),
      grid: grid,
    );
    add(characterComponent);

    const double wallWidth1 = 12.5;
    add(WallComponent(
      location: Vector2(25, 75),
      vertices: [
        Vector2(wallWidth1, wallWidth1),
        Vector2(wallWidth1, -wallWidth1),
        Vector2(-wallWidth1, -wallWidth1),
        Vector2(-wallWidth1, wallWidth1),
      ],
    ));

    const double wallWidth2 = 5;
    add(WallComponent(
      location: Vector2(66.6, 33.3),
      vertices: [
        Vector2(wallWidth2, wallWidth2),
        Vector2(wallWidth2, -wallWidth2),
        Vector2(-wallWidth2, -wallWidth2),
        Vector2(-wallWidth2, wallWidth2),
      ],
    ));

    add(WallComponent(
      location: Vector2(0, 0),
      vertices: [
        Vector2(-0.5, -0.5),
        Vector2(-0.5, 0.5),
        Vector2(58.5, 0.5),
        Vector2(58.5, -0.5),
      ],
    ));

    add(WallComponent(
      location: Vector2(0, 0),
      vertices: [
        Vector2(-0.5, -0.5),
        Vector2(0.5, -0.5),
        Vector2(0.5, 42),
        Vector2(-0.5, 42),
      ],
    ));

    return super.onLoad();
  }
}
