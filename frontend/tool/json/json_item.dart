import 'package:json_annotation/json_annotation.dart';
import '../types/item_type.dart';
import 'json_position.dart';

part 'json_item.g.dart';

@JsonSerializable()
class JsonItem {
  @JsonKey(name: 'type')
  final ItemType type;

  @JsonKey(name: 'position')
  final JsonPosition position;

  JsonItem({
    required this.type,
    required this.position,
  });

  factory JsonItem.fromJson(Map<String, dynamic> json) =>
      _$JsonItemFromJson(json);

  Map<String, dynamic> toJson() => _$JsonItemToJson(this);
}
