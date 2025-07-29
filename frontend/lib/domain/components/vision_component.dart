import 'dart:ui';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';

class VisionComponent extends Component {
  final double sweep;
  final double range;
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.VISION,
    strokeWidth: 0.2,
  );
  final List<Beam> beams = [];

  VisionComponent({
    required this.sweep,
    required this.range,
  }) {
    priority = Priority.vision.value;

    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: -sweep,
      ),
    );
    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: sweep,
      ),
    );
  }

  void show({
    required Vector2 source,
    required double angle,
    required RayCasting rayCasting,
  }) {
    for (final Beam beam in beams) {
      final RayCastingResult result = rayCasting.test(
        source: source,
        angle: angle + beam.angle,
        gap: 0,
        length: range != 0 ? range : 1000,
      );
      beam.update(result);
    }
  }

  void hide() {
    for (final Beam beam in beams) {
      beam.start = Vector2.zero();
      beam.end = Vector2.zero();
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
