import 'dart:ui';
import 'package:commandos/domain/models/beam.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/types/priority.dart';
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
  bool enabled = true;

  LaserComponent({
    required this.laser,
  }) {
    priority = Priority.laser.value;
    final double delta = laser.sweep / laser.numberOfBeams;

    if ((laser.numberOfBeams == 1) || (laser.numberOfBeams > 2)) {
      beams.add(
        Beam(
          start: Vector2.zero(),
          end: Vector2.zero(),
          angle: 0,
        ),
      );
    }

    for (int i = 1; i < laser.numberOfBeams; i++) {
      beams.add(
        Beam(
          start: Vector2.zero(),
          end: Vector2.zero(),
          angle: radians(i * delta),
        ),
      );

      beams.add(
        Beam(
          start: Vector2.zero(),
          end: Vector2.zero(),
          angle: -radians(i * delta),
        ),
      );
    }
  }

  void refresh({
    required Vector2 source,
    required double angle,
    required RayCasting rayCasting,
  }) {
    for (final Beam beam in beams) {
      final RayCastingResult result = rayCasting.test(
        source: source,
        angle: angle + laser.angle + beam.angle,
        range: laser.range != 0 ? laser.range : 1000,
      );
      beam.update(result);
    }

    enabled = true;
  }

  void disable() {
    enabled = false;
  }

  @override
  void render(Canvas canvas) {
    if (enabled) {
      for (final Beam beam in beams) {
        canvas.drawLine(beam.start.toOffset(), beam.end.toOffset(), paint);
      }
    }
  }
}
