import 'package:cavedash_tools/json/json_game_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_level.g.dart';

@JsonSerializable()
class JsonLevel {
  final int id;
  final List<JsonGameObject> walls;
  final List<JsonGameObject> portals;

  const JsonLevel({
    required this.id,
    required this.walls,
    required this.portals,
  });

  factory JsonLevel.fromJson(Map<String, dynamic> json) =>
      _$JsonLevelFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLevelToJson(this);
}
