import 'dart:async';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  LevelComponent();

  @override
  FutureOr onLoad() {
    //final GameEngine engine = GameEngineRef.instance;
    add(CharacterComponent(
      initialPosition: Vector2(0, 0),
      size: Vector2(200, 100),
    ));

    return super.onLoad();
  }
}
