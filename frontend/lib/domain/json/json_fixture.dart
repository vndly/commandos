import 'package:commandos/domain/types/shape_type.dart';
import 'package:commandos/domain/types/types.dart';
import 'package:commandos/extensions/num_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_fixture.g.dart';

@JsonSerializable()
class JsonFixture {
  final String id;
  final ShapeType shapeType;
  final List<Vertex> vertices;
  final num radius;

  const JsonFixture({
    required this.id,
    required this.shapeType,
    required this.vertices,
    required this.radius,
  });

  void adjustVertices(num x, num y) {
    for (final Vertex vertex in vertices) {
      vertex[0] = (vertex[0] - x).rounded();
      vertex[1] = (vertex[1] - y).rounded();
    }
  }

  num get minX {
    num result = double.infinity;

    for (final Vertex vertex in vertices) {
      if (vertex[0] < result) {
        result = vertex[0];
      }
    }

    if (shapeType == ShapeType.circle) {
      return result - radius;
    } else {
      return result;
    }
  }

  num get maxX {
    num result = -double.infinity;

    for (final Vertex vertex in vertices) {
      if (vertex[0] > result) {
        result = vertex[0];
      }
    }

    if (shapeType == ShapeType.circle) {
      return result + radius;
    } else {
      return result;
    }
  }

  num get minY {
    num result = double.infinity;

    for (final Vertex vertex in vertices) {
      if (vertex[1] < result) {
        result = vertex[1];
      }
    }

    if (shapeType == ShapeType.circle) {
      return result - radius;
    } else {
      return result;
    }
  }

  num get maxY {
    num result = -double.infinity;

    for (final Vertex vertex in vertices) {
      if (vertex[1] > result) {
        result = vertex[1];
      }
    }

    if (shapeType == ShapeType.circle) {
      return result + radius;
    } else {
      return result;
    }
  }

  factory JsonFixture.fromJson(Map<String, dynamic> json) =>
      _$JsonFixtureFromJson(json);

  Map<String, dynamic> toJson() => _$JsonFixtureToJson(this);
}
