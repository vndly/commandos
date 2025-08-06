import 'package:commandos/domain/components/door_component.dart';
import 'package:commandos/domain/models/polygon.dart';
import 'package:flame/components.dart';

class Door extends Polygon {
  final DoorStatus status;

  Door({
    required this.status,
    required List<Vector2> points,
  }) : super(points: points);
}
