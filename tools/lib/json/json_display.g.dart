// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_display.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonDisplay _$JsonDisplayFromJson(Map<String, dynamic> json) => JsonDisplay(
      models: (json['models'] as List<dynamic>)
          .map((e) => JsonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: json['offset'] as num,
    );

Map<String, dynamic> _$JsonDisplayToJson(JsonDisplay instance) =>
    <String, dynamic>{
      'models': instance.models,
      'offset': instance.offset,
    };
