import 'dart:async';
import 'dart:ui';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/utils/assets.dart';
import 'package:flame/components.dart';

class MapBackgroundComponent extends SpriteComponent {
  final Grid grid;

  MapBackgroundComponent({
    required this.grid,
  }) : super(
          position: Vector2(0, 0),
          anchor: Anchor.topLeft,
          size: grid.size,
        );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_LEVEL0);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint paint = Paint();
    paint.color = const Color(0xffff0000);
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      paint,
    );

    /*canvas.drawCircle(
      Offset.zero,
      1,
      Paint()..color = const Color(0xFFFF0000),
    );*/
  }
}
