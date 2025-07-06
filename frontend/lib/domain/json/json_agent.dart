import 'package:json_annotation/json_annotation.dart';
import 'json_position.dart';

part 'json_agent.g.dart';

@JsonSerializable()
class JsonAgent {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'position')
  final JsonPosition position;

  JsonAgent({
    required this.id,
    required this.position,
  });

  factory JsonAgent.fromJson(Map<String, dynamic> json) =>
      _$JsonAgentFromJson(json);

  Map<String, dynamic> toJson() => _$JsonAgentToJson(this);
}
