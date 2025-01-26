import 'package:flame/components.dart';

class Portal {
  final PortalType type;
  final double entrance;
  final double exit;
  bool enabled = true;

  Portal({
    required this.type,
    required this.entrance,
    required this.exit,
  });

  void disable() {
    enabled = false;
  }

  Vector2 destination(Vector2 position) {
    if (type == PortalType.horizontal) {
      final double distanceEntrance = (position.x - entrance).abs();
      final double distanceExit = (position.x - exit).abs();

      if (distanceEntrance < distanceExit) {
        return Vector2(exit, position.y);
      } else {
        return Vector2(entrance, position.y);
      }
    } else {
      final double distanceEntrance = (position.y - entrance).abs();
      final double distanceExit = (position.y - exit).abs();

      if (distanceEntrance < distanceExit) {
        return Vector2(position.x, exit);
      } else {
        return Vector2(position.x, entrance);
      }
    }
  }
}

enum PortalType {
  horizontal,
  vertical,
}
