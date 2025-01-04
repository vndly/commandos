import 'dart:ui';
import 'package:cavedash/domain/models/grid.dart';
import 'package:flame/components.dart';

class GridMarkersComponent extends PositionComponent {
  final Grid grid;

  GridMarkersComponent({
    required this.grid,
  }) : super(
          position: Vector2(500, 500),
          anchor: Anchor.center,
          size: grid.size,
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint paintBorder = Paint();
    paintBorder.color = const Color(0xffff0000);
    paintBorder.strokeWidth = 1;
    paintBorder.style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      paintBorder,
    );

    final Paint paintNode = Paint();
    paintNode.color = const Color(0xffff0000);
    paintNode.style = PaintingStyle.fill;

    final double gapX = grid.size.x / (grid.dimensions.x - 1);
    final double gapY = grid.size.y / (grid.dimensions.y - 1);

    for (int x = 0; x < grid.dimensions.x; x++) {
      for (int y = 0; y < grid.dimensions.y; y++) {
        canvas.drawCircle(
          Offset(x * gapX, y * gapY),
          5,
          paintNode,
        );
      }
    }
  }
}
