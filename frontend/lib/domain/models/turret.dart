import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:flame/components.dart';

class Turret {
  final String id;
  final Vector2 position;
  final double angle;
  final List<Laser> lasers;
  final List<Behavior> behaviors;

  Turret({
    required this.id,
    required this.position,
    required this.angle,
    required this.lasers,
    required this.behaviors,
  });
}
