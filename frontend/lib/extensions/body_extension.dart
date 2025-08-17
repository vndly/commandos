import 'package:flame_forge2d/flame_forge2d.dart';

extension BodyExtension on Body {
  void setPosition(Vector2 position) => setTransform(position, angle);

  void setAngle(double angle) => setTransform(position, angle);
}
