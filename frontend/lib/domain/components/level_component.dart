import 'dart:async';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:cavedash/domain/components/grid_component.dart';
import 'package:cavedash/domain/components/map_component.dart';
import 'package:cavedash/domain/components/wall_component.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/domain/state/game/game_engine.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  late final CharacterComponent characterComponent;

  LevelComponent();

  @override
  FutureOr onLoad() {
    final Grid grid = GameEngineRef.instance.grid;

    add(MapBackgroundComponent(
      grid: grid,
    ));

    add(GridComponent(
      grid: grid,
    ));

    characterComponent = CharacterComponent(
      size: Vector2(40, 40),
      grid: grid,
    );

    add(characterComponent);

    const double wallWidth1 = 125;
    add(WallComponent(
      location: Vector2(250, 750),
      vertices: [
        Vector2(wallWidth1, wallWidth1),
        Vector2(wallWidth1, -wallWidth1),
        Vector2(-wallWidth1, -wallWidth1),
        Vector2(-wallWidth1, wallWidth1),
      ],
    ));

    const double wallWidth2 = 50;
    add(WallComponent(
      location: Vector2(666, 333),
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
        Vector2(-5, -5),
        Vector2(-5, 5),
        Vector2(585, 5),
        Vector2(585, -5),
      ],
    ));

    add(WallComponent(
      location: Vector2(0, 0),
      vertices: [
        Vector2(-5, -5),
        Vector2(5, -5),
        Vector2(5, 420),
        Vector2(-5, 420),
      ],
    ));

    return super.onLoad();
  }
}
