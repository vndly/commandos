import 'dart:async';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:cavedash/domain/components/grid_component.dart';
import 'package:cavedash/domain/components/map_component.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  LevelComponent();

  @override
  FutureOr onLoad() {
    final Grid grid = Grid.create();

    add(MapBackgroundComponent(
      grid: grid,
    ));

    add(GridComponent(
      grid: grid,
    ));

    add(CharacterComponent(
      size: Vector2(40, 40),
      grid: grid,
    ));

    return super.onLoad();
  }
}
