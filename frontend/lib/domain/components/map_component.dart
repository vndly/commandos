import 'package:flame/components.dart';

class MapComponent extends PositionComponent {
  MapComponent({
    required super.size,
  }) : super(
         position: Vector2.zero(),
         anchor: Anchor.topLeft,
       );
}
