import 'package:commandos/domain/behaviors/behavior.dart';
import 'package:commandos/domain/types/intermittent_state.dart';
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
  void update(Body body, double dt) {
    currentTime += dt;

    if ((currentState == IntermittentState.on) && (currentTime >= timeOn)) {
      currentTime -= timeOn;
      currentState = IntermittentState.off;
      updatePosition(body);
    } else if ((currentState == IntermittentState.off) &&
        (currentTime >= timeOff)) {
      currentTime -= timeOff;
      currentState = IntermittentState.on;
      updatePosition(body);
    }
  }

  void updatePosition(Body body) {
    switch (currentState) {
      case IntermittentState.on:
        body.setTransform(positionOn, body.angle);
        break;

      case IntermittentState.off:
        body.setTransform(positionOff, body.angle);
        break;
    }
  }

  @override
  void reset(Body body) {
    if (positionOn.isNaN || positionOff.isNaN) {
      positionOn.setValues(body.position.x, body.position.y);
      positionOff.setValues(body.position.x - 1000, body.position.y);
    }

    currentTime = initialTime ?? 0;
    currentState = intermittentState;

    updatePosition(body);
  }
}
