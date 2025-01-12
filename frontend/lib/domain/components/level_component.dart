import 'dart:async';
import 'dart:convert';
import 'package:cavedash/assets/levels/level_0.dart';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:cavedash/domain/components/map_component.dart';
import 'package:cavedash/domain/components/wall_component.dart';
import 'package:cavedash/domain/json/json_game_object.dart';
import 'package:cavedash/domain/json/json_level.dart';
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

    final dynamic json = jsonDecode(ModelsLevelsLevel0.JSON);
    final JsonLevel jsonLevel = JsonLevel.fromJson(json);

    for (final JsonGameObject jsonWall in jsonLevel.walls) {
      add(WallComponent(
        jsonBody: jsonWall.body,
        jsonFixtures: jsonWall.fixtures,
      ));
    }

    return super.onLoad();
  }
}
