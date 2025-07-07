import 'package:json_annotation/json_annotation.dart';

part 'json_laser.g.dart';

@JsonSerializable()
class JsonLaser {
  @JsonKey(name: 'angle')
  final double angle;

  @JsonKey(name: 'length')
  final double length;

  JsonLaser({
    required this.angle,
    required this.length,
  });

  factory JsonLaser.fromJson(Map<String, dynamic> json) =>
      _$JsonLaserFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaserToJson(this);
}
