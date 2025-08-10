import 'package:json_annotation/json_annotation.dart';
import '../types/behavior_type.dart';
import '../types/intermittent_state.dart';
import '../types/rotating_direction.dart';

part 'json_behavior.g.dart';

@JsonSerializable(includeIfNull: false)
class JsonBehavior {
  @JsonKey(name: 'type')
  final BehaviorType type;

  @JsonKey(name: 'trigger')
  final double? trigger;

  @JsonKey(name: 'startX')
  final double? startX;

  @JsonKey(name: 'startY')
  final double? startY;

  @JsonKey(name: 'startAngle')
  final double? startAngle;

  @JsonKey(name: 'speed')
  final double? speed;

  @JsonKey(name: 'speedX')
  final double? speedX;

  @JsonKey(name: 'speedY')
  final double? speedY;

  @JsonKey(name: 'centerX')
  final double? centerX;

  @JsonKey(name: 'centerY')
  final double? centerY;

  @JsonKey(name: 'radius')
  final double? radius;

  @JsonKey(name: 'minX')
  final double? minX;

  @JsonKey(name: 'maxX')
  final double? maxX;

  @JsonKey(name: 'minY')
  final double? minY;

  @JsonKey(name: 'maxY')
  final double? maxY;

  @JsonKey(name: 'minAngle')
  final double? minAngle;

  @JsonKey(name: 'maxAngle')
  final double? maxAngle;

  @JsonKey(name: 'periodX')
  final double? periodX;

  @JsonKey(name: 'periodY')
  final double? periodY;

  @JsonKey(name: 'amplitudeX')
  final double? amplitudeX;

  @JsonKey(name: 'amplitudeY')
  final double? amplitudeY;

  @JsonKey(name: 'timeOn')
  final double? timeOn;

  @JsonKey(name: 'timeOff')
  final double? timeOff;

  @JsonKey(name: 'initialTime')
  final double? initialTime;

  @JsonKey(name: 'rotatingDirection')
  final RotatingDirection? rotatingDirection;

  @JsonKey(name: 'intermittentState')
  final IntermittentState? intermittentState;

  const JsonBehavior({
    required this.type,
    required this.trigger,
    required this.startX,
    required this.startY,
    required this.startAngle,
    required this.speed,
    required this.speedX,
    required this.speedY,
    required this.centerX,
    required this.centerY,
    required this.radius,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.minAngle,
    required this.maxAngle,
    required this.periodX,
    required this.periodY,
    required this.amplitudeX,
    required this.amplitudeY,
    required this.timeOn,
    required this.timeOff,
    required this.initialTime,
    required this.rotatingDirection,
    required this.intermittentState,
  });

  factory JsonBehavior.fromJson(Map<String, dynamic> json) =>
      _$JsonBehaviorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBehaviorToJson(this);
}
