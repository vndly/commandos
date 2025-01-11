// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'json_analytic_value.g.dart';

@JsonSerializable()
class JsonAnalyticValue {
  final String? string_value;
  final String? int_value;
  final double? float_value;
  final double? double_value;

  const JsonAnalyticValue({
    required this.string_value,
    required this.int_value,
    required this.float_value,
    required this.double_value,
  });

  factory JsonAnalyticValue.fromJson(Map<String, dynamic> json) =>
      _$JsonAnalyticValueFromJson(json);

  Map<String, dynamic> toJson() => _$JsonAnalyticValueToJson(this);
}
