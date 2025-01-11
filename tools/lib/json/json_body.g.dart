// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBody _$JsonBodyFromJson(Map<String, dynamic> json) => JsonBody(
      id: json['id'] as String,
      type: $enumDecode(_$BodyTypeEnumMap, json['type']),
      x: json['x'] as num,
      y: json['y'] as num,
      angle: json['angle'] as num,
      speed: json['speed'] as num,
      powerUpType: $enumDecodeNullable(_$PowerUpTypeEnumMap, json['powerUpType']),
    );

Map<String, dynamic> _$JsonBodyToJson(JsonBody instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$BodyTypeEnumMap[instance.type],
      'x': instance.x,
      'y': instance.y,
      'angle': instance.angle,
      'speed': instance.speed,
      'powerUpType': _$PowerUpTypeEnumMap[instance.powerUpType],
    };

const _$BodyTypeEnumMap = {
  BodyType.static: 'static',
  BodyType.kinematic: 'kinematic',
  BodyType.dynamic: 'dynamic',
};

const _$PowerUpTypeEnumMap = {
  PowerUpType.timeFast: 'timeFast',
  PowerUpType.timeSlow: 'timeSlow',
  PowerUpType.shield: 'shield',
};
