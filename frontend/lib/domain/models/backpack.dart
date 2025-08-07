import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/types/item_type.dart';

class Backpack {
  final List<Item> items;

  Backpack({required this.items});

  void add(Item item) {
    items.add(item);
  }

  void remove(Item item) {
    items.remove(item);
  }

  bool contains(ItemType type) => items.any((item) => item.type == type);

  Item? get(ItemType type) {
    for (final item in items) {
      if (item.type == type) {
        return item;
      }
    }

    return null;
  }
}
