import 'package:cavedash_tools/types/behavior_type.dart';
import 'package:cavedash_tools/types/intermittent_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_behavior.g.dart';

@JsonSerializable()
class JsonBehavior {
  final BehaviorType type;
  final num? trigger;
  final num? startX;
  final num? startY;
  final num? startAngle;
  final num? speed;
  final num? speedX;
  final num? speedY;
  final num? centerX;
  final num? centerY;
  final num? radius;
  final num? minX;
  final num? maxX;
  final num? minY;
  final num? maxY;
  final num? periodX;
  final num? periodY;
  final num? amplitudeX;
  final num? amplitudeY;
  final num? timeOn;
  final num? timeOff;
  final num? initialTime;
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
    required this.periodX,
    required this.periodY,
    required this.amplitudeX,
    required this.amplitudeY,
    required this.timeOn,
    required this.timeOff,
    required this.initialTime,
    required this.intermittentState,
  });

  factory JsonBehavior.fromJson(Map<String, dynamic> json) =>
      _$JsonBehaviorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBehaviorToJson(this);
}
