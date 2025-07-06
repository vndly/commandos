import 'package:json_annotation/json_annotation.dart';
import 'json_path.dart';

part 'json_level.g.dart';

@JsonSerializable()
class JsonLevel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'width')
  final int width;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'paths')
  final List<JsonPath> paths;

  @JsonKey(name: 'connections')
  final List<JsonPath> connections;

  const JsonLevel({
    required this.id,
    required this.width,
    required this.height,
    required this.paths,
    required this.connections,
  });

  factory JsonLevel.fromJson(Map<String, dynamic> json) =>
      _$JsonLevelFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLevelToJson(this);
}
