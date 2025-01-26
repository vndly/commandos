import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Input {
  final Set<ActiveInput> activeInputs = {};

  bool get hasInput => activeInputs.isNotEmpty;

  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _checkKey(
      input: ActiveInput.left,
      key1: LogicalKeyboardKey.keyA,
      key2: LogicalKeyboardKey.arrowLeft,
      keysPressed: keysPressed,
    );

    _checkKey(
      input: ActiveInput.right,
      key1: LogicalKeyboardKey.keyD,
      key2: LogicalKeyboardKey.arrowRight,
      keysPressed: keysPressed,
    );

    _checkKey(
      input: ActiveInput.up,
      key1: LogicalKeyboardKey.keyW,
      key2: LogicalKeyboardKey.arrowUp,
      keysPressed: keysPressed,
    );

    _checkKey(
      input: ActiveInput.down,
      key1: LogicalKeyboardKey.keyS,
      key2: LogicalKeyboardKey.arrowDown,
      keysPressed: keysPressed,
    );

    return true;
  }

  void _checkKey({
    required ActiveInput input,
    required LogicalKeyboardKey key1,
    required LogicalKeyboardKey key2,
    required Set<LogicalKeyboardKey> keysPressed,
  }) {
    if (keysPressed.contains(key1) || keysPressed.contains(key2)) {
      activeInputs.add(input);
    } else {
      activeInputs.remove(input);
    }
  }

  void onPanUpdate(Offset delta) {
    /*final double dx = delta.dx;
    final double dy = delta.dy;

    if ((dx.abs() > dy.abs()) && (dx.abs() > Constants.PAN_THRESHOLD)) {
      if (dx > 0) {
        state = InputState.right;
      } else {
        state = InputState.left;
      }
    } else if ((dy.abs() > dx.abs()) && (dy.abs() > Constants.PAN_THRESHOLD)) {
      if (dy > 0) {
        state = InputState.down;
      } else {
        state = InputState.up;
      }
    }*/
  }

  Vector2 get direction {
    if (activeInputs.contains(ActiveInput.left)) {
      return Vector2(-1, 0);
    } else if (activeInputs.contains(ActiveInput.right)) {
      return Vector2(1, 0);
    } else if (activeInputs.contains(ActiveInput.up)) {
      return Vector2(0, -1);
    } else if (activeInputs.contains(ActiveInput.down)) {
      return Vector2(0, 1);
    } else {
      return Vector2.zero();
    }
  }
}

enum ActiveInput {
  left,
  right,
  up,
  down,
}
