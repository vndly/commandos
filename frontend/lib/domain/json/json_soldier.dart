import 'package:json_annotation/json_annotation.dart';
import 'json_behavior.dart';
import 'json_position.dart';

part 'json_soldier.g.dart';

@JsonSerializable()
class JsonSoldier {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'headAngle')
  final double headAngle;

  @JsonKey(name: 'bodyAngle')
  final double bodyAngle;

  @JsonKey(name: 'sweep')
  final double sweep;

  @JsonKey(name: 'range')
  final double range;

  @JsonKey(name: 'behaviors')
  final List<JsonBehavior> behaviors;

  JsonSoldier({
    required this.id,
    required this.position,
    required this.headAngle,
    required this.bodyAngle,
    required this.sweep,
    required this.range,
    required this.behaviors,
  });

  factory JsonSoldier.fromJson(Map<String, dynamic> json) =>
      _$JsonSoldierFromJson(json);

  Map<String, dynamic> toJson() => _$JsonSoldierToJson(this);
}
