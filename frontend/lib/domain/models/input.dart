import 'package:cavedash/app/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Input {
  InputState state = InputState.none;

  bool get hasInput => !state.isNone;

  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    bool handled = false;
    final bool isKeyDown = event is KeyDownEvent;

    if (isKeyDown &&
        (keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft))) {
      state = InputState.left;
      handled = true;
    } else if (isKeyDown &&
        (keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight))) {
      state = InputState.right;
      handled = true;
    } else if (isKeyDown &&
        (keysPressed.contains(LogicalKeyboardKey.keyW) ||
            keysPressed.contains(LogicalKeyboardKey.arrowUp))) {
      state = InputState.up;
      handled = true;
    } else if (isKeyDown &&
        (keysPressed.contains(LogicalKeyboardKey.keyS) ||
            keysPressed.contains(LogicalKeyboardKey.arrowDown))) {
      state = InputState.down;
      handled = true;
    } else {
      state = InputState.none;
    }

    return handled;
  }

  void onPanUpdate(Offset delta) {
    final double dx = delta.dx;
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
    }
  }

  Vector2 get direction {
    switch (state) {
      case InputState.left:
        return Vector2(-1, 0);
      case InputState.right:
        return Vector2(1, 0);
      case InputState.up:
        return Vector2(0, -1);
      case InputState.down:
        return Vector2(0, 1);
      default:
        return Vector2.zero();
    }
  }
}

enum InputState {
  none,
  left,
  right,
  up,
  down;

  bool get isNone => this == InputState.none;
}
