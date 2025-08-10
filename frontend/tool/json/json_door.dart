import 'package:json_annotation/json_annotation.dart';
import '../types/door_status.dart';
import 'json_polygon.dart';

part 'json_door.g.dart';

@JsonSerializable()
class JsonDoor {
  @JsonKey(name: 'status')
  final DoorStatus status;

  @JsonKey(name: 'polygon')
  final JsonPolygon polygon;

  JsonDoor({
    required this.status,
    required this.polygon,
  });

  factory JsonDoor.fromJson(Map<String, dynamic> json) =>
      _$JsonDoorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonDoorToJson(this);
}
