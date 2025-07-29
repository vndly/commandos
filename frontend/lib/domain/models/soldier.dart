import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:flame/components.dart';

class Soldier {
  final String id;
  final Vector2 position;
  final double angle;
  final double sweep;
  final double range;
  final List<Behavior> behaviors;

  Soldier({
    required this.id,
    required this.position,
    required this.angle,
    required this.sweep,
    required this.range,
    required this.behaviors,
  });
}
