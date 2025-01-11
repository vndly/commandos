import 'package:cavedash_tools/json/json_style.dart';
import 'package:cavedash_tools/types/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_layer_polygon.g.dart';

@JsonSerializable()
class JsonLayerPolygon {
  final JsonStyle style;
  final List<Vertex> vertices;
  final bool open;

  const JsonLayerPolygon({
    required this.style,
    required this.vertices,
    required this.open,
  });

  factory JsonLayerPolygon.fromJson(Map<String, dynamic> json) => _$JsonLayerPolygonFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLayerPolygonToJson(this);
}
