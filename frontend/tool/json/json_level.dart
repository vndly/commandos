import 'package:json_annotation/json_annotation.dart';
import 'json_agent.dart';
import 'json_door.dart';
import 'json_item.dart';
import 'json_soldier.dart';
import 'json_turret.dart';
import 'json_wall.dart';

part 'json_level.g.dart';

@JsonSerializable()
class JsonLevel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'width')
  final int width;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'agents')
  final List<JsonAgent> agents;

  @JsonKey(name: 'turrets')
  final List<JsonTurret> turrets;

  @JsonKey(name: 'soldiers')
  final List<JsonSoldier> soldiers;

  @JsonKey(name: 'walls')
  final List<JsonWall> walls;

  @JsonKey(name: 'doors')
  final List<JsonDoor> doors;

  @JsonKey(name: 'items')
  final List<JsonItem> items;

  const JsonLevel({
    required this.id,
    required this.width,
    required this.height,
    required this.agents,
    required this.turrets,
    required this.soldiers,
    required this.walls,
    required this.doors,
    required this.items,
  });

  factory JsonLevel.fromJson(Map<String, dynamic> json) =>
      _$JsonLevelFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLevelToJson(this);
}
