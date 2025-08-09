import 'package:commandos/domain/models/backpack.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackpackComponent extends PositionComponent {
  Backpack? backpack;

  BackpackComponent({
    required super.position,
  }) : super(priority: Priority.backpack.value);

  @override
  Future onLoad() async {
    await super.onLoad();
  }

  void setBackpack(Backpack backpack) {
    this.backpack = backpack;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      const Rect.fromLTRB(0, 0, 50, 10),
      Paint()..color = Colors.red.withAlpha(150),
    );
  }
}
