import 'dart:async';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/utils/ray_casting.dart';

abstract class EnemyComponent extends PhysicalComponent {
  late final RayCasting rayCasting;
  double headAngle = 0;
  double bodyAngle = 0;

  EnemyComponent({
    required super.position,
    required super.size,
    required this.headAngle,
    required this.bodyAngle,
    required super.priority,
  });

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);
  }
}
