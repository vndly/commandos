import 'dart:async';
import 'package:commandos/domain/components/character_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  late final CharacterComponent characterComponent;

  @override
  FutureOr onLoad() async {
    await add(MapComponent());

    characterComponent = CharacterComponent(
      initialPosition: Vector2(0, 850),
      size: Vector2(60, 60),
    );
    await add(characterComponent);

    GameComponentRef.instance.camera.follow(characterComponent);

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
