import 'package:json_annotation/json_annotation.dart';
import 'package:cavedash_tools/json/json_style.dart';

part 'json_layer_circle.g.dart';

@JsonSerializable()
class JsonLayerCircle {
  final JsonStyle style;
  final num cx;
  final num cy;
  final num r;

  const JsonLayerCircle({
    required this.style,
    required this.cx,
    required this.cy,
    required this.r,
  });

  factory JsonLayerCircle.fromJson(Map<String, dynamic> json) => _$JsonLayerCircleFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLayerCircleToJson(this);
}
