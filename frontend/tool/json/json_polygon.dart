import 'package:json_annotation/json_annotation.dart';
import 'json_position.dart';

part 'json_polygon.g.dart';

@JsonSerializable()
class JsonPolygon {
  @JsonKey(name: 'vertices')
  final List<JsonPosition> vertices;

  JsonPolygon({
    required this.vertices,
  });

  factory JsonPolygon.fromJson(Map<String, dynamic> json) =>
      _$JsonPolygonFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPolygonToJson(this);
}
