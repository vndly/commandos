import 'package:commandos/utils/assets.dart';

enum ItemType {
  keycard(Assets.IMAGES_ICONS_KEYCARD);

  final String path;

  const ItemType(this.path);
}
