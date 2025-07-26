import 'dart:async';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';

class MapComponent extends SpriteComponent {
  MapComponent({required super.size})
    : super(
        position: Vector2.zero(),
        anchor: Anchor.topLeft,
        priority: Priority.floor.value,
      );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_GYM);

    return super.onLoad();
  }
}
