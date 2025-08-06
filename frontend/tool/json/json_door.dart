import 'package:json_annotation/json_annotation.dart';
import 'json_position.dart';

part 'json_door.g.dart';

@JsonSerializable()
class JsonDoor {
  @JsonKey(name: 'vertices')
  final List<JsonPosition> vertices;

  JsonDoor({
    required this.vertices,
  });

  factory JsonDoor.fromJson(Map<String, dynamic> json) =>
      _$JsonDoorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonDoorToJson(this);
}
