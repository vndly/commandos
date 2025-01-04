import 'dart:async';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/utils/assets.dart';
import 'package:flame/components.dart';

class MapBackgroundComponent extends SpriteComponent {
  final Grid grid;

  MapBackgroundComponent({
    required this.grid,
  }) : super(
          position: grid.center,
          anchor: Anchor.center,
          size: grid.size * 1.070833333,
        );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_LEVEL0);

    return super.onLoad();
  }
}
