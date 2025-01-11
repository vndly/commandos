import 'package:cavedash_tools/json/json_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_display.g.dart';

@JsonSerializable()
class JsonDisplay {
  final List<JsonModel> models;
  final num offset;

  const JsonDisplay({
    required this.models,
    required this.offset,
  });

  factory JsonDisplay.fromJson(Map<String, dynamic> json) => _$JsonDisplayFromJson(json);

  Map<String, dynamic> toJson() => _$JsonDisplayToJson(this);
}
