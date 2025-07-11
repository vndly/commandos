// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_wall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonWall _$JsonWallFromJson(Map<String, dynamic> json) => JsonWall(
  vertices: (json['vertices'] as List<dynamic>)
      .map((e) => JsonPosition.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonWallToJson(JsonWall instance) => <String, dynamic>{
  'vertices': instance.vertices,
};
