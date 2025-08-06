import 'dart:ui';
import 'package:commandos/domain/models/polygon.dart';
import 'package:flame/components.dart';

class Wall {
  late final Polygon polygon;

  Wall({required List<Vector2> points}) {
    polygon = Polygon(points: points);
  }

  Vector2 get position => polygon.position;

  Vector2 get size => polygon.size;

  List<Vector2> get vertices => polygon.vertices;

  Path get path => polygon.path;
}
