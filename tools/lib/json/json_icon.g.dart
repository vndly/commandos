// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonIcon _$JsonIconFromJson(Map<String, dynamic> json) => JsonIcon(
      name: json['name'] as String,
      width: json['width'] as num,
      height: json['height'] as num,
      layers: (json['layers'] as List<dynamic>).map((e) => JsonLayer.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$JsonIconToJson(JsonIcon instance) => <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'layers': instance.layers,
    };
