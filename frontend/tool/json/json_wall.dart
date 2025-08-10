import 'package:json_annotation/json_annotation.dart';
import 'json_polygon.dart';

part 'json_wall.g.dart';

@JsonSerializable()
class JsonWall {
  @JsonKey(name: 'polygon')
  final JsonPolygon polygon;

  JsonWall({
    required this.polygon,
  });

  factory JsonWall.fromJson(Map<String, dynamic> json) =>
      _$JsonWallFromJson(json);

  Map<String, dynamic> toJson() => _$JsonWallToJson(this);
}
