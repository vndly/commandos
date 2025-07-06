import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Input {
  final Set<ActiveInput> activeInputs = {};

  bool get hasInput => activeInputs.isNotEmpty;

  bool hasActiveInput(ActiveInput input) => activeInputs.contains(input);

  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _checkKey(
      input: ActiveInput.left,
      keys: [LogicalKeyboardKey.keyA, LogicalKeyboardKey.arrowLeft],
      keysPressed: keysPressed,
    );

    _checkKey(
      input: ActiveInput.right,
      keys: [LogicalKeyboardKey.keyD, LogicalKeyboardKey.arrowRight],
      keysPressed: keysPressed,
    );

    _checkKey(
      input: ActiveInput.up,
      keys: [LogicalKeyboardKey.keyW, LogicalKeyboardKey.arrowUp],
      keysPressed: keysPressed,
    );

    _checkKey(
      input: ActiveInput.down,
      keys: [LogicalKeyboardKey.keyS, LogicalKeyboardKey.arrowDown],
      keysPressed: keysPressed,
    );

    return true;
  }

  void _checkKey({
    required ActiveInput input,
    required List<LogicalKeyboardKey> keys,
    required Set<LogicalKeyboardKey> keysPressed,
  }) {
    if (keysPressed.any((key) => keys.contains(key))) {
      activeInputs.add(input);
    } else {
      activeInputs.remove(input);
    }
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

enum ActiveInput { left, right, up, down }
