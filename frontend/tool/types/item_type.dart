import 'package:commandos/utils/assets.dart';

enum ItemType {
  keycard(Assets.IMAGES_ITEMS_KEYCARD);

  final String sprite;

  const ItemType(this.sprite);
}
