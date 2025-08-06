// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_door.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonDoor _$JsonDoorFromJson(Map<String, dynamic> json) => JsonDoor(
  vertices: (json['vertices'] as List<dynamic>)
      .map((e) => JsonPosition.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonDoorToJson(JsonDoor instance) => <String, dynamic>{
  'vertices': instance.vertices,
};
