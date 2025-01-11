import 'package:cavedash_tools/json/json_layer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_icon.g.dart';

@JsonSerializable()
class JsonIcon {
  final String name;
  final num width;
  final num height;
  final List<JsonLayer> layers;

  const JsonIcon({
    required this.name,
    required this.width,
    required this.height,
    required this.layers,
  });

  factory JsonIcon.fromJson(Map<String, dynamic> json) => _$JsonIconFromJson(json);

  Map<String, dynamic> toJson() => _$JsonIconToJson(this);
}
