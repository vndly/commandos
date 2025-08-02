import 'package:commandos/domain/components/game_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

abstract class PhysicalComponent extends BodyComponent<GameComponent> {
  final Vector2 initialPosition;
  final Vector2 size;

  PhysicalComponent({
    required this.initialPosition,
    required this.size,
    required super.priority,
  });
}
