// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_analytic_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonAnalyticEvent _$JsonAnalyticEventFromJson(Map<String, dynamic> json) =>
    JsonAnalyticEvent(
      event_params: (json['event_params'] as List<dynamic>)
          .map((e) => JsonAnalyticParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonAnalyticEventToJson(JsonAnalyticEvent instance) =>
    <String, dynamic>{
      'event_params': instance.event_params,
    };
