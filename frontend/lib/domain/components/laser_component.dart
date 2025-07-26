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
  }) {
    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: 0,
      ),
    );

    for (int i = 1; i < 3; i++) {
      beams.add(
        Beam(
          start: Vector2.zero(),
          end: Vector2.zero(),
          angle: radians(i * 15),
        ),
      );

      beams.add(
        Beam(
          start: Vector2.zero(),
          end: Vector2.zero(),
          angle: -radians(i * 15),
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
        angle: angle + laser.angle + beam.angle,
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
  Vector2 start;
  Vector2 end;
  final double angle;

  Beam({
    required this.start,
    required this.end,
    required this.angle,
  });

  void update(RayCastingResult result) {
    start = result.start;
    end = result.end;
  }
}
