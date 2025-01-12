// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_game_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonGameObject _$JsonGameObjectFromJson(Map<String, dynamic> json) =>
    JsonGameObject(
      body: JsonBody.fromJson(json['body'] as Map<String, dynamic>),
      fixtures: (json['fixtures'] as List<dynamic>)
          .map((e) => JsonFixture.fromJson(e as Map<String, dynamic>))
          .toList(),
      behaviors: (json['behaviors'] as List<dynamic>)
          .map((e) => JsonBehavior.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonGameObjectToJson(JsonGameObject instance) =>
    <String, dynamic>{
      'body': instance.body,
      'fixtures': instance.fixtures,
      'behaviors': instance.behaviors,
    };
