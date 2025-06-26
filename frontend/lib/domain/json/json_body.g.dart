// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBody _$JsonBodyFromJson(Map<String, dynamic> json) => JsonBody(
  type: $enumDecode(_$BodyTypeEnumMap, json['type']),
  x: json['x'] as num,
  y: json['y'] as num,
  angle: json['angle'] as num,
);

Map<String, dynamic> _$JsonBodyToJson(JsonBody instance) => <String, dynamic>{
  'type': _$BodyTypeEnumMap[instance.type]!,
  'x': instance.x,
  'y': instance.y,
  'angle': instance.angle,
};

const _$BodyTypeEnumMap = {
  BodyType.static: 'static',
  BodyType.kinematic: 'kinematic',
  BodyType.dynamic: 'dynamic',
};
