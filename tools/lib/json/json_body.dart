import 'package:cavedash_tools/types/body_type.dart';
import 'package:cavedash_tools/types/power_up_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_body.g.dart';

@JsonSerializable()
class JsonBody {
  final String id;
  final BodyType type;
  final num x;
  final num y;
  final num angle;
  final num speed;
  final PowerUpType? powerUpType;

  const JsonBody({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.angle,
    required this.speed,
    required this.powerUpType,
  });

  factory JsonBody.fromJson(Map<String, dynamic> json) => _$JsonBodyFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBodyToJson(this);
}
