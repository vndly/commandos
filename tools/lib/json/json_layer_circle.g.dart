// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_layer_circle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLayerCircle _$JsonLayerCircleFromJson(Map<String, dynamic> json) =>
    JsonLayerCircle(
      style: JsonStyle.fromJson(json['style'] as Map<String, dynamic>),
      cx: json['cx'] as num,
      cy: json['cy'] as num,
      r: json['r'] as num,
    );

Map<String, dynamic> _$JsonLayerCircleToJson(JsonLayerCircle instance) =>
    <String, dynamic>{
      'style': instance.style,
      'cx': instance.cx,
      'cy': instance.cy,
      'r': instance.r,
    };
