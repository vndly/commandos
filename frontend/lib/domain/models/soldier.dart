import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:flame/components.dart';

class Soldier {
  final String id;
  final Vector2 position;
  final double headAngle;
  final double bodyAngle;
  final double sweep;
  final double range;
  final List<Behavior> behaviors;

  Soldier({
    required this.id,
    required this.position,
    required this.headAngle,
    required this.bodyAngle,
    required this.sweep,
    required this.range,
    required this.behaviors,
  });
}
