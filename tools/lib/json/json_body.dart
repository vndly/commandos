import 'package:cavedash_tools/types/body_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_body.g.dart';

@JsonSerializable()
class JsonBody {
  final String id;
  final BodyType type;
  final num x;
  final num y;
  final num angle;

  const JsonBody({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.angle,
  });

  factory JsonBody.fromJson(Map<String, dynamic> json) =>
      _$JsonBodyFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBodyToJson(this);
}
