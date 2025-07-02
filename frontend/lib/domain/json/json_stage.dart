import 'package:json_annotation/json_annotation.dart';
import 'json_path.dart';

part 'json_stage.g.dart';

@JsonSerializable()
class JsonStage {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'paths')
  final List<JsonPath> paths;

  const JsonStage({required this.id, required this.paths});

  factory JsonStage.fromJson(Map<String, dynamic> json) =>
      _$JsonStageFromJson(json);

  Map<String, dynamic> toJson() => _$JsonStageToJson(this);
}
