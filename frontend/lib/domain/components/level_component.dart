import 'dart:async';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:cavedash/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  LevelComponent();

  @override
  FutureOr onLoad() {
    //final GameEngine engine = GameEngineRef.instance;
    add(LevelBackgroundComponent());

    add(CharacterComponent(
      initialPosition: Vector2(10, 115),
      size: Vector2(5, 5),
    ));

    return super.onLoad();
  }
}

class LevelBackgroundComponent extends SpriteComponent {
  LevelBackgroundComponent()
      : super(
          size: Vector2(250, 125),
          position: Vector2(0, 0),
          anchor: Anchor.topLeft,
        );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_LEVEL0);

    return super.onLoad();
  }
}
