import 'package:flame_forge2d/flame_forge2d.dart';

abstract class Behavior {
  const Behavior();

  void update(Body body, double dt);

  void reset(Body body);
}
