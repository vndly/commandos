// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLevel _$JsonLevelFromJson(Map<String, dynamic> json) => JsonLevel(
  id: json['id'] as String,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  paths: (json['paths'] as List<dynamic>)
      .map((e) => JsonPath.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonLevelToJson(JsonLevel instance) => <String, dynamic>{
  'id': instance.id,
  'width': instance.width,
  'height': instance.height,
  'paths': instance.paths,
};
