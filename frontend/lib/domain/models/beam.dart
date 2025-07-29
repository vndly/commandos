import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';

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
