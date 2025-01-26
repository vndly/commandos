import 'dart:async';
import 'dart:convert';
import 'package:cavedash/assets/levels/level_0.dart';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:cavedash/domain/components/map_component.dart';
import 'package:cavedash/domain/components/portal_component.dart';
import 'package:cavedash/domain/components/wall_component.dart';
import 'package:cavedash/domain/json/json_game_object.dart';
import 'package:cavedash/domain/json/json_level.dart';
import 'package:cavedash/domain/models/portal.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  late final CharacterComponent characterComponent;

  @override
  FutureOr onLoad() {
    add(MapBackgroundComponent());

    characterComponent = CharacterComponent(
      size: Vector2(4, 4),
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

    final Portal portal = Portal(
      type: PortalType.vertical,
      entrance: 0,
      exit: 100,
    );

    for (final JsonGameObject jsonPortal in jsonLevel.portals) {
      add(PortalComponent(
        id: jsonPortal.id,
        jsonBody: jsonPortal.body,
        jsonFixtures: jsonPortal.fixtures,
        portal: portal,
      ));
    }

    return super.onLoad();
  }
}
