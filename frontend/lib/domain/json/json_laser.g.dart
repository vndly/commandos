// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_laser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLaser _$JsonLaserFromJson(Map<String, dynamic> json) => JsonLaser(
  angle: (json['angle'] as num).toDouble(),
  sweep: (json['sweep'] as num).toDouble(),
  range: (json['range'] as num).toDouble(),
  numberOfBeams: (json['numberOfBeams'] as num).toInt(),
);

Map<String, dynamic> _$JsonLaserToJson(JsonLaser instance) => <String, dynamic>{
  'angle': instance.angle,
  'sweep': instance.sweep,
  'range': instance.range,
  'numberOfBeams': instance.numberOfBeams,
};
