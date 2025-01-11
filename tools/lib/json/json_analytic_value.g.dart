// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_analytic_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonAnalyticValue _$JsonAnalyticValueFromJson(Map<String, dynamic> json) => JsonAnalyticValue(
      string_value: json['string_value'] as String?,
      int_value: json['int_value'] as String?,
      float_value: (json['float_value'] as num?)?.toDouble(),
      double_value: (json['double_value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$JsonAnalyticValueToJson(JsonAnalyticValue instance) => <String, dynamic>{
      'string_value': instance.string_value,
      'int_value': instance.int_value,
      'float_value': instance.float_value,
      'double_value': instance.double_value,
    };
