import 'package:commandos/domain/types/item_type.dart';
import 'package:flame/game.dart';

class Item {
  final ItemType type;
  final Vector2 position;

  const Item({
    required this.type,
    required this.position,
  });
}
