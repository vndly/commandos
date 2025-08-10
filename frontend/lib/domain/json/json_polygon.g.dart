// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_polygon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPolygon _$JsonPolygonFromJson(Map<String, dynamic> json) => JsonPolygon(
  vertices: (json['vertices'] as List<dynamic>)
      .map((e) => JsonPosition.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonPolygonToJson(JsonPolygon instance) =>
    <String, dynamic>{'vertices': instance.vertices};
