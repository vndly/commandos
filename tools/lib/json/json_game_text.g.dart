// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_game_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonGameText _$JsonGameTextFromJson(Map<String, dynamic> json) => JsonGameText(
      x: json['x'] as num,
      y: json['y'] as num,
      text: json['text'] as String,
      color: json['color'] as String,
      size: json['size'] as num,
    );

Map<String, dynamic> _$JsonGameTextToJson(JsonGameText instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'text': instance.text,
      'color': instance.color,
      'size': instance.size,
    };
