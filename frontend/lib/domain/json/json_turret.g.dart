// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_turret.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonTurret _$JsonTurretFromJson(Map<String, dynamic> json) => JsonTurret(
  id: json['id'] as String,
  position: JsonPosition.fromJson(json['position'] as Map<String, dynamic>),
  angle: (json['angle'] as num).toDouble(),
  lasers: (json['lasers'] as List<dynamic>)
      .map((e) => JsonLaser.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonTurretToJson(JsonTurret instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'angle': instance.angle,
      'lasers': instance.lasers,
    };
