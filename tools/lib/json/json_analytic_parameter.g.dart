// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_analytic_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonAnalyticParameter _$JsonAnalyticParameterFromJson(Map<String, dynamic> json) => JsonAnalyticParameter(
      key: json['key'] as String,
      value: JsonAnalyticValue.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonAnalyticParameterToJson(JsonAnalyticParameter instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
