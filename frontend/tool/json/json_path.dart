import 'package:json_annotation/json_annotation.dart';
import 'json_location.dart';

part 'json_path.g.dart';

@JsonSerializable()
class JsonPath {
  @JsonKey(name: 'a')
  final JsonLocation a;

  @JsonKey(name: 'b')
  final JsonLocation b;

  const JsonPath({required this.a, required this.b});

  factory JsonPath.fromJson(Map<String, dynamic> json) =>
      _$JsonPathFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPathToJson(this);

  @override
  String toString() => '($a, $b)';
}
