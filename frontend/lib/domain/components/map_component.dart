import 'dart:async';
import 'package:commandos/app/constants.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class MapBackgroundComponent extends SpriteComponent {
  MapBackgroundComponent()
    : super(position: Constants.MAP_CENTER, anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_LEVEL_0);
    size = sprite!.image.size / Constants.MAP_GRID_RATIO;

    return super.onLoad();
  }
}
