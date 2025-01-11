// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:cavedash_tools/json/json_analytic_parameter.dart';

part 'json_analytic_event.g.dart';

@JsonSerializable()
class JsonAnalyticEvent {
  final List<JsonAnalyticParameter> event_params;

  const JsonAnalyticEvent({required this.event_params});

  static List<JsonAnalyticEvent> fromFile(String filePath) {
    final File file = File(filePath);
    final String content = file.readAsStringSync();
    final List<String> lines = content.split('\n');
    final List<JsonAnalyticEvent> result = [];

    for (final String line in lines) {
      if (line.trim().isNotEmpty) {
        final Map<String, dynamic> entry = jsonDecode(line) as Map<String, dynamic>;
        result.add(JsonAnalyticEvent.fromJson(entry));
      }
    }

    return result;
  }

  T get<T>(String key, T defaultValue) {
    for (final JsonAnalyticParameter parameter in event_params) {
      if (parameter.key == key) {
        if (parameter.value.string_value != null) {
          return parameter.value.string_value as T;
        } else if (parameter.value.int_value != null) {
          return int.parse(parameter.value.int_value as String) as T;
        } else if (parameter.value.float_value != null) {
          return parameter.value.float_value as T;
        } else if (parameter.value.double_value != null) {
          return parameter.value.double_value as T;
        }
      }
    }

    return defaultValue;
  }

  factory JsonAnalyticEvent.fromJson(Map<String, dynamic> json) => _$JsonAnalyticEventFromJson(json);

  Map<String, dynamic> toJson() => _$JsonAnalyticEventToJson(this);
}
