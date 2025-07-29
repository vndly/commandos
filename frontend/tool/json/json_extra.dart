import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'json_soldier.dart';
import 'json_turret.dart';

part 'json_extra.g.dart';

@JsonSerializable()
class JsonExtra {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'turrets')
  final List<JsonTurret> turrets;

  @JsonKey(name: 'soldiers')
  final List<JsonSoldier> soldiers;

  JsonExtra({
    required this.id,
    required this.turrets,
    required this.soldiers,
  });

  factory JsonExtra.fromString(String input) {
    final dynamic json = jsonDecode(input);

    return JsonExtra.fromJson(json);
  }

  factory JsonExtra.fromJson(Map<String, dynamic> json) =>
      _$JsonExtraFromJson(json);

  Map<String, dynamic> toJson() => _$JsonExtraToJson(this);
}
