import 'package:json_annotation/json_annotation.dart';
import 'package:cavedash_tools/json/json_behavior.dart';
import 'package:cavedash_tools/json/json_body.dart';
import 'package:cavedash_tools/json/json_model.dart';

part 'json_game_object.g.dart';

@JsonSerializable()
class JsonGameObject {
  final JsonBody body;
  final List<JsonModel> models;
  final List<JsonBehavior> behaviors;

  const JsonGameObject({
    required this.body,
    required this.models,
    required this.behaviors,
  });

  factory JsonGameObject.fromJson(Map<String, dynamic> json) => _$JsonGameObjectFromJson(json);

  Map<String, dynamic> toJson() => _$JsonGameObjectToJson(this);
}
