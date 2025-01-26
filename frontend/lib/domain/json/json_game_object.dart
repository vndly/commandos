import 'package:cavedash/domain/json/json_behavior.dart';
import 'package:cavedash/domain/json/json_body.dart';
import 'package:cavedash/domain/json/json_fixture.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_game_object.g.dart';

@JsonSerializable()
class JsonGameObject {
  final String id;
  final JsonBody body;
  final List<JsonFixture> fixtures;
  final List<JsonBehavior> behaviors;

  const JsonGameObject({
    required this.id,
    required this.body,
    required this.fixtures,
    required this.behaviors,
  });

  factory JsonGameObject.fromJson(Map<String, dynamic> json) =>
      _$JsonGameObjectFromJson(json);

  Map<String, dynamic> toJson() => _$JsonGameObjectToJson(this);
}
