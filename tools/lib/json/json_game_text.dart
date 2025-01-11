import 'package:json_annotation/json_annotation.dart';

part 'json_game_text.g.dart';

@JsonSerializable()
class JsonGameText {
  final num x;
  final num y;
  final String text;
  final String color;
  final num size;

  const JsonGameText({
    required this.x,
    required this.y,
    required this.text,
    required this.color,
    required this.size,
  });

  factory JsonGameText.fromJson(Map<String, dynamic> json) =>
      _$JsonGameTextFromJson(json);

  Map<String, dynamic> toJson() => _$JsonGameTextToJson(this);
}
