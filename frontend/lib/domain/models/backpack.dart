import 'package:commandos/domain/types/item_type.dart';

class Backpack {
  final Map<ItemType, int> _items;

  Backpack({required Map<ItemType, int> items}) : _items = items;

  bool get hasItems => _items.isNotEmpty;

  List<MapEntry<ItemType, int>> get items => _items.entries.toList();

  int get size => _items.length;

  void add(ItemType item) {
    _items[item] = (_items[item] ?? 0) + 1;
  }

  void remove(ItemType item) {
    _items[item] = (_items[item] ?? 0) - 1;

    if (_items[item] == 0) {
      _items.remove(item);
    }
  }

  bool contains(ItemType type) => _items.keys.any((item) => item == type);
}
