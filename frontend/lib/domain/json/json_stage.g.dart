// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonStage _$JsonStageFromJson(Map<String, dynamic> json) => JsonStage(
  id: json['id'] as String,
  paths: (json['paths'] as List<dynamic>)
      .map((e) => JsonPath.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonStageToJson(JsonStage instance) => <String, dynamic>{
  'id': instance.id,
  'paths': instance.paths,
};
