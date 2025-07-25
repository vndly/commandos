import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/behaviors/harmonic_behavior.dart';
import 'package:commandos/domain/behaviors/intermittent_behavior.dart';
import 'package:commandos/domain/behaviors/moving_behavior.dart';
import 'package:commandos/domain/behaviors/orbiting_behavior.dart';
import 'package:commandos/domain/behaviors/oscillating_behavior.dart';
import 'package:commandos/domain/behaviors/rotating_behavior.dart';
import 'package:commandos/domain/types/behavior_type.dart';
import 'package:commandos/domain/types/intermittent_state.dart';
import 'package:commandos/domain/types/rotating_direction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_behavior.g.dart';

@JsonSerializable()
class JsonBehavior {
  final BehaviorType type;
  final double? trigger;
  final double? startX;
  final double? startY;
  final double? startAngle;
  final double? speed;
  final double? speedX;
  final double? speedY;
  final double? centerX;
  final double? centerY;
  final double? radius;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final double? minAngle;
  final double? maxAngle;
  final double? periodX;
  final double? periodY;
  final double? amplitudeX;
  final double? amplitudeY;
  final double? timeOn;
  final double? timeOff;
  final double? initialTime;
  final RotatingDirection? rotatingDirection;
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

  Behavior getBehavior() {
    switch (type) {
      case BehaviorType.rotating:
        return RotatingBehavior(
          startAngle: startAngle!,
          rotationSpeed: speed!,
          direction: rotatingDirection!,
          minAngle: minAngle,
          maxAngle: maxAngle,
        );

      case BehaviorType.orbiting:
        return OrbitingBehavior(
          startAngle: startAngle!,
          centerX: centerX!,
          centerY: centerY!,
          radius: radius!,
          angularSpeed: speed!,
        );

      case BehaviorType.oscillating:
        return OscillatingBehavior(
          startX: startX!,
          startY: startY!,
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          speedX: speedX,
          speedY: speedY,
        );

      case BehaviorType.moving:
        return MovingBehavior(
          trigger: trigger!,
          startX: startX!,
          startY: startY!,
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          speedX: speedX,
          speedY: speedY,
        );

      case BehaviorType.harmonic:
        return HarmonicBehavior(
          startX: startX!,
          startY: startY!,
          periodX: periodX,
          periodY: periodY,
          amplitudeX: amplitudeX,
          amplitudeY: amplitudeY,
          initialTime: initialTime,
        );

      case BehaviorType.intermittent:
        return IntermittentBehavior(
          timeOn: timeOn!,
          timeOff: timeOff!,
          intermittentState: intermittentState!,
          initialTime: initialTime,
        );
    }
  }

  factory JsonBehavior.fromJson(Map<String, dynamic> json) =>
      _$JsonBehaviorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBehaviorToJson(this);
}
