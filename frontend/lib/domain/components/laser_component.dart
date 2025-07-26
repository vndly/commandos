import 'dart:ui';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';

class LaserComponent extends Component {
  final Laser laser;
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.LASER,
    strokeWidth: 0.5,
  );
  final List<Beam> beams = [];

  LaserComponent({
    required this.laser,
    required Vector2 start,
    required Vector2 end,
  }) {
    for (int i = 0; i < 1; i++) {
      beams.add(
        Beam(
          start: start,
          end: end,
        ),
      );
    }
  }

  void test({
    required Vector2 source,
    required double angle,
    required RayCasting rayCasting,
  }) {
    for (final Beam beam in beams) {
      final RayCastingResult result = rayCasting.test(
        source: source,
        angle: angle + laser.angle,
        gap: 0, //size.x / 2,
        length: laser.range,
      );
      beam.update(result);
    }
  }

  @override
  void render(Canvas canvas) {
    for (final Beam beam in beams) {
      canvas.drawLine(beam.start.toOffset(), beam.end.toOffset(), paint);
    }
  }
}

class Beam {
  final Vector2 start;
  final Vector2 end;

  const Beam({
    required this.start,
    required this.end,
  });

  void update(RayCastingResult result) {
    start.setFrom(result.start);
    end.setFrom(result.end);
  }
}
