import 'package:commandos/domain/models/polygon.dart';
import 'package:flame/components.dart';

class Wall extends Polygon {
  Wall({required List<Vector2> points}) : super(points: points);
}
