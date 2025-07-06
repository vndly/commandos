// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonAgent _$JsonAgentFromJson(Map<String, dynamic> json) => JsonAgent(
  id: json['id'] as String,
  position: JsonPosition.fromJson(json['position'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JsonAgentToJson(JsonAgent instance) => <String, dynamic>{
  'id': instance.id,
  'position': instance.position,
};
