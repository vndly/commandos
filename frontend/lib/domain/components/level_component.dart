import 'dart:async';
import 'dart:convert';
import 'package:commandos/assets/levels/gym.dart';
import 'package:commandos/domain/components/character_component.dart';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/map_component.dart';
import 'package:commandos/domain/json/json_level.dart';
import 'package:commandos/domain/models/node.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  final List<Node> nodes = [];
  late final CharacterComponent characterComponent;

  @override
  FutureOr onLoad() async {
    final dynamic json = jsonDecode(LevelGym.JSON);
    final JsonLevel jsonLevel = JsonLevel.fromJson(json);
    nodes.addAll(jsonLevel.nodes);

    await add(MapComponent());

    characterComponent = CharacterComponent(
      initialPosition: Vector2(0, 850),
      size: Vector2(60, 60),
      nodes: nodes,
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
