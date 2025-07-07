import 'package:commandos/domain/models/laser.dart';
import 'package:flame/components.dart';

class Turret {
  final String id;
  final Vector2 position;
  final List<Laser> lasers;

  Turret({
    required this.id,
    required this.position,
    required this.lasers,
  });
}
