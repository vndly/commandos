import 'dart:async';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:flame/components.dart';

class DoorComponent extends PositionComponent with HasGameReference {
  final String pathTop;
  final String pathBottom;

  DoorComponent({
    required this.pathTop,
    required this.pathBottom,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    await level.add(
      DoorSpriteComponent(
        path: pathTop,
        position: position,
        size: size,
        priority: Priority.map_1.value,
      ),
    );

    await level.add(
      DoorSpriteComponent(
        path: pathBottom,
        position: position,
        size: size,
        priority: Priority.map_0.value,
      ),
    );

    return super.onLoad();
  }
}

class DoorSpriteComponent extends SpriteComponent {
  final String path;

  DoorSpriteComponent({
    required this.path,
    required super.position,
    required super.size,
    required super.priority,
  }) : super(
         anchor: Anchor.center,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(path);

    return super.onLoad();
  }
}
