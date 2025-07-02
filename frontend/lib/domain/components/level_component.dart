import 'dart:async';
import 'package:commandos/domain/components/character_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  late final CharacterComponent characterComponent;

  @override
  FutureOr onLoad() {
    add(MapBackgroundComponent());

    characterComponent = CharacterComponent(
      initialPosition: Vector2(0, 0),
      size: Vector2(10, 10),
    );
    add(characterComponent);

    /*final dynamic json = jsonDecode(ModelsLevelsLevel0.JSON);
    final JsonLevel jsonLevel = JsonLevel.fromJson(json);

    for (final JsonGameObject jsonWall in jsonLevel.walls) {
      add(
        WallComponent(jsonBody: jsonWall.body, jsonFixtures: jsonWall.fixtures),
      );
    }*/

    return super.onLoad();
  }
}
