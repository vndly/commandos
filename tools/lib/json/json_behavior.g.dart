// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_behavior.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBehavior _$JsonBehaviorFromJson(Map<String, dynamic> json) => JsonBehavior(
      type: $enumDecode(_$BehaviorTypeEnumMap, json['type']),
      trigger: json['trigger'] as num?,
      startX: json['startX'] as num?,
      startY: json['startY'] as num?,
      startAngle: json['startAngle'] as num?,
      speed: json['speed'] as num?,
      speedX: json['speedX'] as num?,
      speedY: json['speedY'] as num?,
      centerX: json['centerX'] as num?,
      centerY: json['centerY'] as num?,
      radius: json['radius'] as num?,
      minX: json['minX'] as num?,
      maxX: json['maxX'] as num?,
      minY: json['minY'] as num?,
      maxY: json['maxY'] as num?,
      periodX: json['periodX'] as num?,
      periodY: json['periodY'] as num?,
      amplitudeX: json['amplitudeX'] as num?,
      amplitudeY: json['amplitudeY'] as num?,
      timeOn: json['timeOn'] as num?,
      timeOff: json['timeOff'] as num?,
      initialTime: json['initialTime'] as num?,
      intermittentState: $enumDecodeNullable(
          _$IntermittentStateEnumMap, json['intermittentState']),
    );

Map<String, dynamic> _$JsonBehaviorToJson(JsonBehavior instance) =>
    <String, dynamic>{
      'type': _$BehaviorTypeEnumMap[instance.type],
      'trigger': instance.trigger,
      'startX': instance.startX,
      'startY': instance.startY,
      'startAngle': instance.startAngle,
      'speed': instance.speed,
      'speedX': instance.speedX,
      'speedY': instance.speedY,
      'centerX': instance.centerX,
      'centerY': instance.centerY,
      'radius': instance.radius,
      'minX': instance.minX,
      'maxX': instance.maxX,
      'minY': instance.minY,
      'maxY': instance.maxY,
      'periodX': instance.periodX,
      'periodY': instance.periodY,
      'amplitudeX': instance.amplitudeX,
      'amplitudeY': instance.amplitudeY,
      'timeOn': instance.timeOn,
      'timeOff': instance.timeOff,
      'initialTime': instance.initialTime,
      'intermittentState':
          _$IntermittentStateEnumMap[instance.intermittentState],
    };

const _$BehaviorTypeEnumMap = {
  BehaviorType.rotating: 'rotating',
  BehaviorType.orbiting: 'orbiting',
  BehaviorType.oscillating: 'oscillating',
  BehaviorType.moving: 'moving',
  BehaviorType.harmonic: 'harmonic',
  BehaviorType.intermittent: 'intermittent',
  BehaviorType.shooting: 'shooting',
};

const _$IntermittentStateEnumMap = {
  IntermittentState.on: 'on',
  IntermittentState.off: 'off',
};
