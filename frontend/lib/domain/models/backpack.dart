import 'package:commandos/domain/types/item_type.dart';

class Backpack {
  final Map<ItemType, int> items;

  Backpack({required this.items});

  void add(ItemType item) {
    items[item] = (items[item] ?? 0) + 1;
  }

  void remove(ItemType item) {
    items[item] = (items[item] ?? 0) - 1;

    if (items[item] == 0) {
      items.remove(item);
    }
  }

  bool contains(ItemType type) => items.keys.any((item) => item == type);
}
