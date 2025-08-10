import 'package:json_annotation/json_annotation.dart';
import 'json_polygon.dart';
import 'json_position.dart';

part 'json_portal.g.dart';

@JsonSerializable()
class JsonPortal {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'entrance')
  final JsonPosition entrance;

  @JsonKey(name: 'exit')
  final JsonPosition exit;

  @JsonKey(name: 'polygon')
  final JsonPolygon polygon;

  JsonPortal({
    required this.id,
    required this.entrance,
    required this.exit,
    required this.polygon,
  });

  factory JsonPortal.fromJson(Map<String, dynamic> json) =>
      _$JsonPortalFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPortalToJson(this);
}
