import 'package:commandos/domain/components/item_component.dart';
import 'package:commandos/domain/models/backpack.dart';
import 'package:commandos/domain/types/item_type.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackpackComponent extends PositionComponent {
  Backpack? backpack;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.BACKPACK_BACKGROUND,
  );
  final Paint paintBorder = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.BACKPACK_BORDER,
  );

  BackpackComponent({
    required super.position,
  }) : super(priority: Priority.backpack.value);

  void setBackpack(Backpack backpack) {
    this.backpack = backpack;
    refresh();
  }

  void refresh() {
    removeAll(children);

    int index = 0;

    for (final MapEntry<ItemType, int> item in backpack!.items) {
      add(
        ItemSpriteComponent(
          item: item.key,
          position: Vector2((index * 10) + 5, 5),
          size: Vector2(5, 5),
        ),
      );
      index++;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if ((backpack != null) && (backpack!.hasItems)) {
      canvas.drawRect(
        Rect.fromLTRB(0, 0, backpack!.size * 10, 10),
        paintFill,
      );

      canvas.drawRect(
        Rect.fromLTRB(0, 0, backpack!.size * 10, 10),
        paintBorder,
      );
    }
  }
}
