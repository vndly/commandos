// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_portal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPortal _$JsonPortalFromJson(Map<String, dynamic> json) => JsonPortal(
  id: json['id'] as String,
  entrance: JsonPosition.fromJson(json['entrance'] as Map<String, dynamic>),
  exit: JsonPosition.fromJson(json['exit'] as Map<String, dynamic>),
  polygon: JsonPolygon.fromJson(json['polygon'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JsonPortalToJson(JsonPortal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entrance': instance.entrance,
      'exit': instance.exit,
      'polygon': instance.polygon,
    };
