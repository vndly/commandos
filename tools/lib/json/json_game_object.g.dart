// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_game_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonGameObject _$JsonGameObjectFromJson(Map<String, dynamic> json) =>
    JsonGameObject(
      body: JsonBody.fromJson(json['body'] as Map<String, dynamic>),
      models: (json['models'] as List<dynamic>)
          .map((e) => JsonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      behaviors: (json['behaviors'] as List<dynamic>)
          .map((e) => JsonBehavior.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonGameObjectToJson(JsonGameObject instance) =>
    <String, dynamic>{
      'body': instance.body,
      'models': instance.models,
      'behaviors': instance.behaviors,
    };
