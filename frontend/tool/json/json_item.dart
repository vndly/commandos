import 'package:json_annotation/json_annotation.dart';
import '../types/item_type.dart';

part 'json_item.g.dart';

@JsonSerializable()
class JsonItem {
  @JsonKey(name: 'type')
  final ItemType type;

  JsonItem({
    required this.type,
  });

  factory JsonItem.fromJson(Map<String, dynamic> json) =>
      _$JsonItemFromJson(json);

  Map<String, dynamic> toJson() => _$JsonItemToJson(this);
}
