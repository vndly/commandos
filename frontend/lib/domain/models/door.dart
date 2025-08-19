import 'package:commandos/domain/models/polygon.dart';
import 'package:commandos/domain/types/door_status.dart';
import 'package:flame/components.dart';

class Door extends Polygon {
  DoorStatus status;

  Door({
    required this.status,
    required List<Vector2> points,
  }) : super(points: points);

  void unlock() {
    status = DoorStatus.unlocked;
  }
}
