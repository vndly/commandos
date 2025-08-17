import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/components/enemy_component.dart';
import 'package:commandos/domain/types/intermittent_state.dart';
import 'package:commandos/extensions/body_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class IntermittentBehavior extends Behavior {
  final Vector2 positionOn = Vector2(double.nan, double.nan);
  final Vector2 positionOff = Vector2(double.nan, double.nan);
  final double? initialTime;
  double currentTime = 0;
  IntermittentState currentState = IntermittentState.on;

  final double timeOn;
  final double timeOff;
  final IntermittentState intermittentState;

  IntermittentBehavior({
    required this.timeOn,
    required this.timeOff,
    required this.intermittentState,
    required this.initialTime,
  });

  @override
  void update(EnemyComponent enemy, double dt) {
    currentTime += dt;

    if ((currentState == IntermittentState.on) && (currentTime >= timeOn)) {
      currentTime -= timeOn;
      currentState = IntermittentState.off;
      updatePosition(enemy);
    } else if ((currentState == IntermittentState.off) &&
        (currentTime >= timeOff)) {
      currentTime -= timeOff;
      currentState = IntermittentState.on;
      updatePosition(enemy);
    }
  }

  void updatePosition(EnemyComponent enemy) {
    switch (currentState) {
      case IntermittentState.on:
        enemy.body.setPosition(positionOn);
        break;

      case IntermittentState.off:
        enemy.body.setPosition(positionOff);
        break;
    }
  }

  @override
  void reset(EnemyComponent enemy) {
    if (positionOn.isNaN || positionOff.isNaN) {
      positionOn.setValues(enemy.body.position.x, enemy.body.position.y);
      positionOff.setValues(
        enemy.body.position.x - 1000,
        enemy.body.position.y,
      );
    }

    currentTime = initialTime ?? 0;
    currentState = intermittentState;

    updatePosition(enemy);
  }
}
