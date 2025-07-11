import 'package:json_annotation/json_annotation.dart';
import 'json_position.dart';

part 'json_wall.g.dart';

@JsonSerializable()
class JsonWall {
  @JsonKey(name: 'vertices')
  final List<JsonPosition> vertices;

  JsonWall({
    required this.vertices,
  });

  factory JsonWall.fromJson(Map<String, dynamic> json) =>
      _$JsonWallFromJson(json);

  Map<String, dynamic> toJson() => _$JsonWallToJson(this);
}
