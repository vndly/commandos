import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Input {
  KeyEvent? lastEvent;
  final Set<ActiveInput> activeInputs = {};

  bool get hasInput => activeInputs.isNotEmpty;

  bool hasActiveInput(ActiveInput input) => activeInputs.contains(input);

  void onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    lastEvent = event;

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

  bool _isPressing({
    required KeyEvent event,
    required Set<LogicalKeyboardKey> keysPressed,
    required LogicalKeyboardKey key,
  }) => (event is KeyDownEvent) && keysPressed.contains(key);

  bool isSwitchingAgentForward(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) =>
      _isPressing(
        event: event,
        keysPressed: keysPressed,
        key: LogicalKeyboardKey.tab,
      ) &&
      !_isPressing(
        event: event,
        keysPressed: keysPressed,
        key: LogicalKeyboardKey.shiftLeft,
      );

  bool isSwitchingAgentBackward(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) =>
      _isPressing(
        event: event,
        keysPressed: keysPressed,
        key: LogicalKeyboardKey.tab,
      ) &&
      _isPressing(
        event: event,
        keysPressed: keysPressed,
        key: LogicalKeyboardKey.shiftLeft,
      );

  bool isDebugOff(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) => _isPressing(
    event: event,
    keysPressed: keysPressed,
    key: LogicalKeyboardKey.digit0,
  );

  bool isDebugMode1(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) => _isPressing(
    event: event,
    keysPressed: keysPressed,
    key: LogicalKeyboardKey.digit1,
  );

  bool isDebugMode2(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) => _isPressing(
    event: event,
    keysPressed: keysPressed,
    key: LogicalKeyboardKey.digit2,
  );

  bool isDebugMode3(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) => _isPressing(
    event: event,
    keysPressed: keysPressed,
    key: LogicalKeyboardKey.digit3,
  );

  Vector2 get direction {
    double x = 0;
    double y = 0;

    if (hasActiveInput(ActiveInput.left)) {
      x = -1;
    } else if (hasActiveInput(ActiveInput.right)) {
      x = 1;
    }

    if (hasActiveInput(ActiveInput.up)) {
      y = -1;
    } else if (hasActiveInput(ActiveInput.down)) {
      y = 1;
    }

    if (x != 0 && y != 0) {
      return Vector2(x / sqrt2, y / sqrt2);
    } else {
      return Vector2(x, y);
    }
  }
}

enum ActiveInput { left, right, up, down }
