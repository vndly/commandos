// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_fixture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonFixture _$JsonFixtureFromJson(Map<String, dynamic> json) => JsonFixture(
  id: json['id'] as String,
  shapeType: $enumDecode(_$ShapeTypeEnumMap, json['shapeType']),
  vertices: (json['vertices'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => e as num).toList())
      .toList(),
  radius: json['radius'] as num,
);

Map<String, dynamic> _$JsonFixtureToJson(JsonFixture instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shapeType': _$ShapeTypeEnumMap[instance.shapeType]!,
      'vertices': instance.vertices,
      'radius': instance.radius,
    };

const _$ShapeTypeEnumMap = {
  ShapeType.polygon: 'polygon',
  ShapeType.circle: 'circle',
};
