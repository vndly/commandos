import 'package:cavedash_tools/json/json_game_object.dart';
import 'package:cavedash_tools/json/json_game_text.dart';
import 'package:cavedash_tools/json/json_stars.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_level.g.dart';

@JsonSerializable()
class JsonLevel {
  final int id;
  final JsonGameObject portal;
  final JsonGameObject spikes;
  final List<JsonGameObject> enemies;
  final List<JsonGameObject> powerUps;
  final List<JsonGameObject> coins;
  final List<JsonGameText> texts;
  final JsonStars stars;

  const JsonLevel({
    required this.id,
    required this.portal,
    required this.spikes,
    required this.enemies,
    required this.powerUps,
    required this.coins,
    required this.texts,
    required this.stars,
  });

  factory JsonLevel.fromJson(Map<String, dynamic> json) => _$JsonLevelFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLevelToJson(this);
}
