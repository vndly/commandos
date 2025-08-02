import 'dart:async';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:flame/components.dart';

class MapComponent extends PositionComponent {
  final String path0;
  final String path1;
  final String path2;

  MapComponent({
    required this.path0,
    required this.path1,
    required this.path2,
    required super.size,
  }) : super(
         position: Vector2.zero(),
         anchor: Anchor.topLeft,
       );

  @override
  FutureOr onLoad() async {
    await level.add(
      MapSpriteComponent(
        path: path0,
        priority: Priority.map_0.value,
        size: size,
      ),
    );

    await level.add(
      MapSpriteComponent(
        path: path1,
        priority: Priority.map_1.value,
        size: size,
      ),
    );

    await level.add(
      MapSpriteComponent(
        path: path2,
        priority: Priority.map_2.value,
        size: size,
      ),
    );

    /*decorator.addLast(
      PaintDecorator.tint(
        const Color(0xbb000000),
      ),
    );*/

    return super.onLoad();
  }
}

class MapSpriteComponent extends SpriteComponent {
  final String path;

  MapSpriteComponent({
    required this.path,
    required super.priority,
    required super.size,
  }) : super(
         position: Vector2.zero(),
         anchor: Anchor.topLeft,
       );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(path);

    return super.onLoad();
  }
}
