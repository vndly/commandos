import 'dart:async';
import 'dart:ui';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/domain/models/node.dart';
import 'package:flame/components.dart';

class GridComponent extends PositionComponent {
  final Grid grid;

  GridComponent({
    required this.grid,
  }) : super(
          position: grid.center,
          anchor: Anchor.center,
          size: grid.size,
        );

  @override
  FutureOr onLoad() {
    for (final node in grid.nodes) {
      add(NodeComponent(
        node: node,
        position: Vector2(
          node.index.x * (grid.gapX / 2),
          node.index.y * (grid.gapY / 2),
        ),
      ));
    }

    return super.onLoad();
  }

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
    paintNode.color = const Color(0xffffff00);
    paintNode.style = PaintingStyle.stroke;

    for (final node in grid.nodes) {
      canvas.drawCircle(
        Offset(node.position.x, node.position.y),
        7,
        paintNode,
      );
    }
  }
}

class NodeComponent extends PositionComponent {
  final Node node;

  NodeComponent({
    required this.node,
    required super.position,
  }) : super(
          anchor: Anchor.center,
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint paintNode = Paint();
    paintNode.color = const Color(0xffff0000);
    paintNode.style = PaintingStyle.fill;

    canvas.drawCircle(
      center.toOffset(),
      5,
      paintNode,
    );
  }
}
