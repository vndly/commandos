import 'package:cavedash_tools/json/json_layer_circle.dart';
import 'package:cavedash_tools/json/json_layer_polygon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_layer.g.dart';

@JsonSerializable()
class JsonLayer {
  final JsonLayerCircle? circle;
  final JsonLayerPolygon? polygon;

  const JsonLayer({
    this.circle,
    this.polygon,
  });

  factory JsonLayer.fromJson(Map<String, dynamic> json) =>
      _$JsonLayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLayerToJson(this);
}
