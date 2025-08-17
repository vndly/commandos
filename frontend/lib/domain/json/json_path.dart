import 'package:json_annotation/json_annotation.dart';
import 'json_position.dart';

part 'json_path.g.dart';

@JsonSerializable()
class JsonPath {
  @JsonKey(name: 'a')
  final JsonPosition a;

  @JsonKey(name: 'b')
  final JsonPosition b;

  const JsonPath({required this.a, required this.b});

  factory JsonPath.fromJson(Map<String, dynamic> json) =>
      _$JsonPathFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPathToJson(this);
}
