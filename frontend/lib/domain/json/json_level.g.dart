// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLevel _$JsonLevelFromJson(Map<String, dynamic> json) => JsonLevel(
  id: json['id'] as String,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  paths: (json['paths'] as List<dynamic>)
      .map((e) => JsonPath.fromJson(e as Map<String, dynamic>))
      .toList(),
  portals: (json['portals'] as List<dynamic>)
      .map((e) => JsonPath.fromJson(e as Map<String, dynamic>))
      .toList(),
  agents: (json['agents'] as List<dynamic>)
      .map((e) => JsonAgent.fromJson(e as Map<String, dynamic>))
      .toList(),
  turrets: (json['turrets'] as List<dynamic>)
      .map((e) => JsonTurret.fromJson(e as Map<String, dynamic>))
      .toList(),
  soldiers: (json['soldiers'] as List<dynamic>)
      .map((e) => JsonSoldier.fromJson(e as Map<String, dynamic>))
      .toList(),
  walls: (json['walls'] as List<dynamic>)
      .map((e) => JsonWall.fromJson(e as Map<String, dynamic>))
      .toList(),
  doors: (json['doors'] as List<dynamic>)
      .map((e) => JsonDoor.fromJson(e as Map<String, dynamic>))
      .toList(),
  items: (json['items'] as List<dynamic>)
      .map((e) => JsonItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JsonLevelToJson(JsonLevel instance) => <String, dynamic>{
  'id': instance.id,
  'width': instance.width,
  'height': instance.height,
  'paths': instance.paths,
  'portals': instance.portals,
  'agents': instance.agents,
  'turrets': instance.turrets,
  'soldiers': instance.soldiers,
  'walls': instance.walls,
  'doors': instance.doors,
  'items': instance.items,
};
