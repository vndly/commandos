import 'package:json_annotation/json_annotation.dart';
import 'json_polygon.dart';

part 'json_portal.g.dart';

@JsonSerializable()
class JsonPortal {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'entrance')
  final JsonPolygon entrance;

  @JsonKey(name: 'exit')
  final JsonPolygon exit;

  JsonPortal({
    required this.id,
    required this.entrance,
    required this.exit,
  });

  factory JsonPortal.fromJson(Map<String, dynamic> json) =>
      _$JsonPortalFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPortalToJson(this);
}
