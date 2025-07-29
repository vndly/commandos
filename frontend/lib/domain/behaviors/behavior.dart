import 'package:commandos/domain/components/enemy_component.dart';

abstract class Behavior {
  const Behavior();

  void update(EnemyComponent body, double dt);

  void reset(EnemyComponent body);
}
