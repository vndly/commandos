// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_door.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonDoor _$JsonDoorFromJson(Map<String, dynamic> json) => JsonDoor(
  status: $enumDecode(_$DoorStatusEnumMap, json['status']),
  polygon: JsonPolygon.fromJson(json['polygon'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JsonDoorToJson(JsonDoor instance) => <String, dynamic>{
  'status': _$DoorStatusEnumMap[instance.status]!,
  'polygon': instance.polygon,
};

const _$DoorStatusEnumMap = {
  DoorStatus.closed: 'closed',
  DoorStatus.opened: 'opened',
};
