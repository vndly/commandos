// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_soldier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonSoldier _$JsonSoldierFromJson(Map<String, dynamic> json) => JsonSoldier(
  id: json['id'] as String,
  position: JsonPosition.fromJson(json['position'] as Map<String, dynamic>),
  headAngle: (json['headAngle'] as num).toDouble(),
  bodyAngle: (json['bodyAngle'] as num).toDouble(),
  sweep: (json['sweep'] as num).toDouble(),
  range: (json['range'] as num).toDouble(),
  behaviors: (json['behaviors'] as List<dynamic>)
      .map((e) => JsonBehavior.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonSoldierToJson(JsonSoldier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'headAngle': instance.headAngle,
      'bodyAngle': instance.bodyAngle,
      'sweep': instance.sweep,
      'range': instance.range,
      'behaviors': instance.behaviors,
    };
