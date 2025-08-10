// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_portal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPortal _$JsonPortalFromJson(Map<String, dynamic> json) => JsonPortal(
  id: json['id'] as String,
  entrance: JsonPolygon.fromJson(json['entrance'] as Map<String, dynamic>),
  exit: JsonPolygon.fromJson(json['exit'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JsonPortalToJson(JsonPortal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entrance': instance.entrance,
      'exit': instance.exit,
    };
