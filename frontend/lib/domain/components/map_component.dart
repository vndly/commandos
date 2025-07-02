import 'dart:async';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';

class MapBackgroundComponent extends SpriteComponent {
  MapBackgroundComponent()
    : super(position: Vector2.zero(), anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_GYM);
    //size = sprite!.image.size / Constants.MAP_GRID_RATIO;

    return super.onLoad();
  }
}
