// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLayer _$JsonLayerFromJson(Map<String, dynamic> json) => JsonLayer(
      circle: json['circle'] == null ? null : JsonLayerCircle.fromJson(json['circle'] as Map<String, dynamic>),
      polygon: json['polygon'] == null ? null : JsonLayerPolygon.fromJson(json['polygon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonLayerToJson(JsonLayer instance) => <String, dynamic>{
      'circle': instance.circle,
      'polygon': instance.polygon,
    };
