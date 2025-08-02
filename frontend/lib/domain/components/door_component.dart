import 'dart:async';
import 'package:commandos/domain/types/priority.dart';
import 'package:flame/components.dart';

class DoorComponent extends SpriteComponent {
  final String path;

  DoorComponent({
    required this.path,
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.door.value,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(path);

    return super.onLoad();
  }
}
