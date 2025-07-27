import 'package:json_annotation/json_annotation.dart';

part 'json_laser.g.dart';

@JsonSerializable()
class JsonLaser {
  @JsonKey(name: 'angle')
  final double angle;

  @JsonKey(name: 'sweep')
  final double sweep;

  @JsonKey(name: 'range')
  final double range;

  @JsonKey(name: 'numberOfBeams')
  final int numberOfBeams;

  JsonLaser({
    required this.angle,
    required this.sweep,
    required this.range,
    required this.numberOfBeams,
  });

  factory JsonLaser.fromJson(Map<String, dynamic> json) =>
      _$JsonLaserFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaserToJson(this);
}
