import 'dart:async';
import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

abstract class EnemyComponent extends BodyComponent<GameComponent> {
  late final RayCasting rayCasting;
  final Vector2 initialPosition;
  final Vector2 size;
  double facingAngle = 0;

  EnemyComponent({
    required this.initialPosition,
    required this.size,
    required this.facingAngle,
    required super.priority,
  });

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);
  }
}
