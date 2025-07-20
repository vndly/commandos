import 'dart:ui';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';

class LaserComponent extends Component {
  final Laser laser;
  Vector2 start;
  Vector2 end;
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.LASER,
    strokeWidth: 0.5,
  );

  LaserComponent({
    required this.laser,
    required this.start,
    required this.end,
  });

  void updatePoints({
    required Vector2 start,
    required Vector2 end,
  }) {
    this.start = start;
    this.end = end;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawLine(start.toOffset(), end.toOffset(), paint);
  }
}
