import 'dart:async';
import 'package:flame/components.dart';

class MapComponent extends SpriteComponent {
  final String path;

  MapComponent({
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

    /*decorator.addLast(
      PaintDecorator.tint(
        const Color(0xbb000000),
      ),
    );*/

    return super.onLoad();
  }
}
