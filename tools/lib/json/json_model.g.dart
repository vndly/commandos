// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonModel _$JsonModelFromJson(Map<String, dynamic> json) => JsonModel(
      id: json['id'] as String,
      fixture: json['fixture'] as bool,
      graphic: json['graphic'] as bool,
      type: $enumDecode(_$ModelTypeEnumMap, json['type']),
      vertices: (json['vertices'] as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => e as num).toList()).toList(),
      radius: json['radius'] as num,
      width: json['width'] as num,
      height: json['height'] as num,
      style: JsonStyle.fromJson(json['style'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonModelToJson(JsonModel instance) => <String, dynamic>{
      'id': instance.id,
      'fixture': instance.fixture,
      'graphic': instance.graphic,
      'type': _$ModelTypeEnumMap[instance.type],
      'vertices': instance.vertices,
      'radius': instance.radius,
      'width': instance.width,
      'height': instance.height,
      'style': instance.style,
    };

const _$ModelTypeEnumMap = {
  ModelType.polygon: 'polygon',
  ModelType.line: 'line',
  ModelType.circle: 'circle',
  ModelType.ellipse: 'ellipse',
};
