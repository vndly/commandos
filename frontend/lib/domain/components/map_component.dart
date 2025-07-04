import 'dart:async';
import 'dart:ui';
import 'package:commandos/domain/models/node.dart';
import 'package:commandos/utils/assets.dart';
import 'package:flame/components.dart';

class MapComponent extends SpriteComponent {
  final List<Node> nodes;

  MapComponent({required this.nodes})
    : super(position: Vector2.zero(), anchor: Anchor.topLeft);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_LEVELS_GYM);

    add(PathsComponent(nodes: nodes));

    return super.onLoad();
  }
}

class PathsComponent extends PositionComponent {
  final Paint paint = Paint()
    ..color = const Color(0xffff0000)
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;
  final List<Node> nodes;

  PathsComponent({required this.nodes})
    : super(position: Vector2.zero(), anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    for (final node in nodes) {
      final Vector2 position = node.position;
      canvas.drawCircle(position.toOffset(), 5, paint);
    }

    super.render(canvas);
  }
}
