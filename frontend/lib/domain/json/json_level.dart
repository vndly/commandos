import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'json_agent.dart';
import 'json_path.dart';
import 'json_turret.dart';

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

  @JsonKey(name: 'agents')
  final List<JsonAgent> agents;

  @JsonKey(name: 'turrets')
  final List<JsonTurret> turrets;

  const JsonLevel({
    required this.id,
    required this.width,
    required this.height,
    required this.paths,
    required this.connections,
    required this.agents,
    required this.turrets,
  });

  factory JsonLevel.fromString(String input) {
    final dynamic json = jsonDecode(input);

    return JsonLevel.fromJson(json);
  }

  factory JsonLevel.fromJson(Map<String, dynamic> json) =>
      _$JsonLevelFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLevelToJson(this);
}
