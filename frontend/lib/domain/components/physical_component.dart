import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

abstract class PhysicalComponent extends BodyComponent<GameComponent> {
  final Vector2 initialPosition;
  final Vector2 size;
  bool _toRemove = false;

  PhysicalComponent({
    required Vector2 position,
    required this.size,
    super.priority,
  }) : initialPosition = position;

  @override
  void update(double dt) {
    super.update(dt);
    checkDebug();

    if (_toRemove) {
      _toRemove = false;
      removeFromParent();
      onRemoved();
    }
  }

  void toBeRemoved() {
    _toRemove = true;
  }

  void onRemoved() {}
}
