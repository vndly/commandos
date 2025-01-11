import 'package:json_annotation/json_annotation.dart';

part 'json_stars.g.dart';

@JsonSerializable()
class JsonStars {
  final int star1;
  final int star2;
  final int star3;

  const JsonStars({
    required this.star1,
    required this.star2,
    required this.star3,
  });

  factory JsonStars.fromJson(Map<String, dynamic> json) => _$JsonStarsFromJson(json);

  Map<String, dynamic> toJson() => _$JsonStarsToJson(this);
}
