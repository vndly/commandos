import 'package:json_annotation/json_annotation.dart';
import 'package:cavedash_tools/json/json_analytic_value.dart';

part 'json_analytic_parameter.g.dart';

@JsonSerializable()
class JsonAnalyticParameter {
  final String key;
  final JsonAnalyticValue value;

  const JsonAnalyticParameter({
    required this.key,
    required this.value,
  });

  factory JsonAnalyticParameter.fromJson(Map<String, dynamic> json) => _$JsonAnalyticParameterFromJson(json);

  Map<String, dynamic> toJson() => _$JsonAnalyticParameterToJson(this);
}
