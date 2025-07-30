import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:flame/components.dart';

class Turret {
  final String id;
  final Vector2 position;
  final double headAngle;
  final double bodyAngle;
  final List<Laser> lasers;
  final List<Behavior> behaviors;

  Turret({
    required this.id,
    required this.position,
    required this.headAngle,
    required this.bodyAngle,
    required this.lasers,
    required this.behaviors,
  });
}
