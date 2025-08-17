import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Input {
  Vector2 previousDirection = Vector2.zero();
  final Set<ActiveInput> activeInputs = {};

  bool get hasInput => activeInputs.isNotEmpty;

  bool hasActiveInput(ActiveInput input) => activeInputs.contains(input);

  void onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
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

  bool isInteracting(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) => _isPressing(
    event: event,
    keysPressed: keysPressed,
    key: LogicalKeyboardKey.keyE,
  );

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

  bool isDebugMode4(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) => _isPressing(
    event: event,
    keysPressed: keysPressed,
    key: LogicalKeyboardKey.digit4,
  );

  Vector2 get direction {
    if (hasActiveInput(ActiveInput.left)) {
      return Vector2(-1, 0);
    } else if (hasActiveInput(ActiveInput.right)) {
      return Vector2(1, 0);
    } else if (hasActiveInput(ActiveInput.up)) {
      return Vector2(0, -1);
    } else if (hasActiveInput(ActiveInput.down)) {
      return Vector2(0, 1);
    } else {
      return Vector2(0, 0);
    }
  }
}

enum ActiveInput {
  left,
  right,
  up,
  down,
}
