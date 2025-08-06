import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';

class Polygon {
  late final Vector2 position;
  late final Vector2 size;
  late final List<Vector2> vertices;

  Polygon({required List<Vector2> points}) {
    position = _center(points);
    size = _size(points);
    vertices = _vertices(
      vertices: points,
      center: position,
      size: size,
    );
  }

  Vector2 _center(List<Vector2> vertices) {
    double sumX = 0;
    double sumY = 0;

    for (final Vector2 vertex in vertices) {
      sumX += vertex.x;
      sumY += vertex.y;
    }

    return Vector2(sumX / vertices.length, sumY / vertices.length);
  }

  Vector2 _size(List<Vector2> vertices) {
    double minX = vertices.first.x;
    double maxX = vertices.first.x;
    double minY = vertices.first.y;
    double maxY = vertices.first.y;

    for (final Vector2 vertex in vertices) {
      if (vertex.x < minX) {
        minX = vertex.x;
      }
      if (vertex.x > maxX) {
        maxX = vertex.x;
      }
      if (vertex.y < minY) {
        minY = vertex.y;
      }
      if (vertex.y > maxY) {
        maxY = vertex.y;
      }
    }

    return Vector2(maxX - minX, maxY - minY);
  }

  List<Vector2> _vertices({
    required List<Vector2> vertices,
    required Vector2 center,
    required Vector2 size,
  }) => vertices.map((v) => v - center).toList();

  Path get path {
    final Path result = Path();
    result.moveTo(
      vertices[0].x,
      vertices[0].y,
    );

    for (int i = 1; i < vertices.length; i++) {
      result.lineTo(
        vertices[i].x,
        vertices[i].y,
      );
    }

    result.close();

    return result;
  }
}
