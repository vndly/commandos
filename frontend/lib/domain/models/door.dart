import 'package:commandos/domain/components/door_component.dart';
import 'package:flame/components.dart';

class Door {
  final Vector2 position;
  final Vector2 size;
  final DoorStatus status;

  const Door({
    required this.position,
    required this.size,
    required this.status,
  });
}
