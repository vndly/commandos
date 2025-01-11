// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLevel _$JsonLevelFromJson(Map<String, dynamic> json) => JsonLevel(
      id: json['id'] as int,
      portal: JsonGameObject.fromJson(json['portal'] as Map<String, dynamic>),
      spikes: JsonGameObject.fromJson(json['spikes'] as Map<String, dynamic>),
      enemies: (json['enemies'] as List<dynamic>)
          .map((e) => JsonGameObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      powerUps: (json['powerUps'] as List<dynamic>)
          .map((e) => JsonGameObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      coins: (json['coins'] as List<dynamic>)
          .map((e) => JsonGameObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      texts: (json['texts'] as List<dynamic>)
          .map((e) => JsonGameText.fromJson(e as Map<String, dynamic>))
          .toList(),
      stars: JsonStars.fromJson(json['stars'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonLevelToJson(JsonLevel instance) => <String, dynamic>{
      'id': instance.id,
      'portal': instance.portal,
      'spikes': instance.spikes,
      'enemies': instance.enemies,
      'powerUps': instance.powerUps,
      'coins': instance.coins,
      'texts': instance.texts,
      'stars': instance.stars,
    };
