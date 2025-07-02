// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLevel _$JsonLevelFromJson(Map<String, dynamic> json) => JsonLevel(
  id: json['id'] as String,
  paths: (json['paths'] as List<dynamic>)
      .map((e) => JsonPath.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonLevelToJson(JsonLevel instance) => <String, dynamic>{
  'id': instance.id,
  'paths': instance.paths,
};
