import 'dart:async';
import 'package:commandos/domain/types/priority.dart';
import 'package:flame/components.dart';

class LightComponent extends SpriteComponent {
  final String path;

  LightComponent({
    required this.path,
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.light.value,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(path);

    return super.onLoad();
  }
}
