// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_extra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonExtra _$JsonExtraFromJson(Map<String, dynamic> json) => JsonExtra(
  id: json['id'] as String,
  turrets: (json['turrets'] as List<dynamic>)
      .map((e) => JsonTurret.fromJson(e as Map<String, dynamic>))
      .toList(),
  soldiers: (json['soldiers'] as List<dynamic>)
      .map((e) => JsonSoldier.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonExtraToJson(JsonExtra instance) => <String, dynamic>{
  'id': instance.id,
  'turrets': instance.turrets,
  'soldiers': instance.soldiers,
};
