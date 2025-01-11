import 'package:json_annotation/json_annotation.dart';
import 'package:tension_tunnel_tools/extensions/num_extension.dart';
import 'package:tension_tunnel_tools/json/json_style.dart';
import 'package:tension_tunnel_tools/types/model_type.dart';
import 'package:tension_tunnel_tools/types/types.dart';

part 'json_model.g.dart';

@JsonSerializable()
class JsonModel {
  final String id;
  final bool fixture;
  final bool graphic;
  final ModelType type;
  final List<Vertex> vertices;
  final num radius;
  final num width;
  final num height;
  final JsonStyle style;

  const JsonModel({
    required this.id,
    required this.fixture,
    required this.graphic,
    required this.type,
    required this.vertices,
    required this.radius,
    required this.width,
    required this.height,
    required this.style,
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

    if (type == ModelType.circle) {
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

    if (type == ModelType.circle) {
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

    if (type == ModelType.circle) {
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

    if (type == ModelType.circle) {
      return result + radius;
    } else {
      return result;
    }
  }

  factory JsonModel.fromJson(Map<String, dynamic> json) => _$JsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$JsonModelToJson(this);
}
