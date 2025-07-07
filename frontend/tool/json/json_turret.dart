import 'package:commandos/domain/json/json_laser.dart';
import 'package:json_annotation/json_annotation.dart';
import 'json_position.dart';

part 'json_turret.g.dart';

@JsonSerializable()
class JsonTurret {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'angle')
  final double angle;

  @JsonKey(name: 'lasers')
  final List<JsonLaser> lasers;

  JsonTurret({
    required this.id,
    required this.position,
    required this.angle,
    required this.lasers,
  });

  factory JsonTurret.fromJson(Map<String, dynamic> json) =>
      _$JsonTurretFromJson(json);

  Map<String, dynamic> toJson() => _$JsonTurretToJson(this);
}
