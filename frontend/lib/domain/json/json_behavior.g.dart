// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_behavior.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBehavior _$JsonBehaviorFromJson(Map<String, dynamic> json) => JsonBehavior(
  type: $enumDecode(_$BehaviorTypeEnumMap, json['type']),
  trigger: (json['trigger'] as num?)?.toDouble(),
  startX: (json['startX'] as num?)?.toDouble(),
  startY: (json['startY'] as num?)?.toDouble(),
  startAngle: (json['startAngle'] as num?)?.toDouble(),
  speed: (json['speed'] as num?)?.toDouble(),
  speedX: (json['speedX'] as num?)?.toDouble(),
  speedY: (json['speedY'] as num?)?.toDouble(),
  centerX: (json['centerX'] as num?)?.toDouble(),
  centerY: (json['centerY'] as num?)?.toDouble(),
  radius: (json['radius'] as num?)?.toDouble(),
  minX: (json['minX'] as num?)?.toDouble(),
  maxX: (json['maxX'] as num?)?.toDouble(),
  minY: (json['minY'] as num?)?.toDouble(),
  maxY: (json['maxY'] as num?)?.toDouble(),
  minAngle: (json['minAngle'] as num?)?.toDouble(),
  maxAngle: (json['maxAngle'] as num?)?.toDouble(),
  periodX: (json['periodX'] as num?)?.toDouble(),
  periodY: (json['periodY'] as num?)?.toDouble(),
  amplitudeX: (json['amplitudeX'] as num?)?.toDouble(),
  amplitudeY: (json['amplitudeY'] as num?)?.toDouble(),
  timeOn: (json['timeOn'] as num?)?.toDouble(),
  timeOff: (json['timeOff'] as num?)?.toDouble(),
  initialTime: (json['initialTime'] as num?)?.toDouble(),
  rotatingDirection: $enumDecodeNullable(
    _$RotatingDirectionEnumMap,
    json['rotatingDirection'],
  ),
  intermittentState: $enumDecodeNullable(
    _$IntermittentStateEnumMap,
    json['intermittentState'],
  ),
);

Map<String, dynamic> _$JsonBehaviorToJson(
  JsonBehavior instance,
) => <String, dynamic>{
  'type': _$BehaviorTypeEnumMap[instance.type]!,
  'trigger': ?instance.trigger,
  'startX': ?instance.startX,
  'startY': ?instance.startY,
  'startAngle': ?instance.startAngle,
  'speed': ?instance.speed,
  'speedX': ?instance.speedX,
  'speedY': ?instance.speedY,
  'centerX': ?instance.centerX,
  'centerY': ?instance.centerY,
  'radius': ?instance.radius,
  'minX': ?instance.minX,
  'maxX': ?instance.maxX,
  'minY': ?instance.minY,
  'maxY': ?instance.maxY,
  'minAngle': ?instance.minAngle,
  'maxAngle': ?instance.maxAngle,
  'periodX': ?instance.periodX,
  'periodY': ?instance.periodY,
  'amplitudeX': ?instance.amplitudeX,
  'amplitudeY': ?instance.amplitudeY,
  'timeOn': ?instance.timeOn,
  'timeOff': ?instance.timeOff,
  'initialTime': ?instance.initialTime,
  'rotatingDirection': ?_$RotatingDirectionEnumMap[instance.rotatingDirection],
  'intermittentState': ?_$IntermittentStateEnumMap[instance.intermittentState],
};

const _$BehaviorTypeEnumMap = {
  BehaviorType.rotating: 'rotating',
  BehaviorType.orbiting: 'orbiting',
  BehaviorType.oscillating: 'oscillating',
  BehaviorType.moving: 'moving',
  BehaviorType.harmonic: 'harmonic',
  BehaviorType.intermittent: 'intermittent',
};

const _$RotatingDirectionEnumMap = {
  RotatingDirection.clockwise: 'clockwise',
  RotatingDirection.counter_clockwise: 'counter_clockwise',
};

const _$IntermittentStateEnumMap = {
  IntermittentState.on: 'on',
  IntermittentState.off: 'off',
};
