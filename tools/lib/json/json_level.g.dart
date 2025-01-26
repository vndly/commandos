// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLevel _$JsonLevelFromJson(Map<String, dynamic> json) => JsonLevel(
      id: (json['id'] as num).toInt(),
      walls: (json['walls'] as List<dynamic>)
          .map((e) => JsonGameObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      portals: (json['portals'] as List<dynamic>)
          .map((e) => JsonGameObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonLevelToJson(JsonLevel instance) => <String, dynamic>{
      'id': instance.id,
      'walls': instance.walls,
      'portals': instance.portals,
    };
