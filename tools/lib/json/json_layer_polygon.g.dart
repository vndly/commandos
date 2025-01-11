// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_layer_polygon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLayerPolygon _$JsonLayerPolygonFromJson(Map<String, dynamic> json) => JsonLayerPolygon(
      style: JsonStyle.fromJson(json['style'] as Map<String, dynamic>),
      vertices: (json['vertices'] as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => e as num).toList()).toList(),
      open: json['open'] as bool,
    );

Map<String, dynamic> _$JsonLayerPolygonToJson(JsonLayerPolygon instance) => <String, dynamic>{
      'style': instance.style,
      'vertices': instance.vertices,
      'open': instance.open,
    };
