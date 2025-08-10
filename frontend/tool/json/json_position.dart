import 'package:json_annotation/json_annotation.dart';

part 'json_position.g.dart';

@JsonSerializable()
class JsonPosition {
  @JsonKey(name: 'x')
  final double x;

  @JsonKey(name: 'y')
  final double y;

  const JsonPosition({required this.x, required this.y});

  factory JsonPosition.create(double x, double y) =>
      JsonPosition(x: round(x), y: round(y));

  static double round(double value) => (value * 10).round() / 10;

  factory JsonPosition.fromJson(Map<String, dynamic> json) =>
      _$JsonPositionFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPositionToJson(this);
}
