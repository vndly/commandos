import 'dart:async';
import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/utils/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class MapBackgroundComponent extends SpriteComponent {
  final Grid grid;

  MapBackgroundComponent({
    required this.grid,
  }) : super(
          position: grid.center,
          anchor: Anchor.center,
        );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_LEVEL0);
    size = sprite!.image.size / Constants.MAP_GRID_RATIO;

    return super.onLoad();
  }
}
