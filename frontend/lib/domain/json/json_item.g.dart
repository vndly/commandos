// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonItem _$JsonItemFromJson(Map<String, dynamic> json) => JsonItem(
  type: $enumDecode(_$ItemTypeEnumMap, json['type']),
  position: JsonPosition.fromJson(json['position'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JsonItemToJson(JsonItem instance) => <String, dynamic>{
  'type': _$ItemTypeEnumMap[instance.type]!,
  'position': instance.position,
};

const _$ItemTypeEnumMap = {ItemType.keycard: 'keycard'};
