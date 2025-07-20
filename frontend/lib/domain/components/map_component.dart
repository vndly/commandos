import 'dart:async';
import 'dart:ui';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/utils/assets.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';

class MapComponent extends SpriteComponent {
  final Nodes nodes;

  MapComponent({required this.nodes, required super.size})
    : super(
        position: Vector2.zero(),
        anchor: Anchor.topLeft,
      );

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_GYM);

    return super.onLoad();
  }
}

class PathsComponent extends PositionComponent {
  final Paint paint = Palette.paint(
    style: PaintingStyle.fill,
    color: const Color(0xffff0000),
  );
  final Nodes nodes;

  PathsComponent({required this.nodes})
    : super(position: Vector2.zero(), anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    for (final Node node in nodes) {
      final Vector2 position = node.position;
      canvas.drawCircle(position.toOffset(), 0.5, paint);
    }

    super.render(canvas);
  }
}
