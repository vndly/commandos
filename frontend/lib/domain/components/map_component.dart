import 'dart:async';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';

class MapComponent extends SpriteComponent {
  MapComponent() : super(position: Vector2.zero(), anchor: Anchor.topLeft);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_GYM);

    return super.onLoad();
  }
}
