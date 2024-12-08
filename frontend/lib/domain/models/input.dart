import 'package:flutter/services.dart';

class Input {
  InputState state = InputState.none;

  bool onKeyEvent(Set<LogicalKeyboardKey> keysPressed) {
    bool handled = false;

    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      state = InputState.left;
      handled = true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      state = InputState.right;
      handled = true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      state = InputState.up;
      handled = true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      state = InputState.down;
      handled = true;
    } else {
      state = InputState.none;
    }

    return handled;
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
