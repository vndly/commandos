class Debug {
  static bool hasBodyDebug = false;
  static bool hasFpsDebug = false;
  static bool hasAgentVision = false;

  static void set(DebugMode flag) {
    switch (flag) {
      case DebugMode.off:
        hasBodyDebug = false;
        hasFpsDebug = false;
        hasAgentVision = false;
        break;
      case DebugMode.mode1:
        hasBodyDebug = !hasBodyDebug;
        break;
      case DebugMode.mode2:
        hasFpsDebug = !hasFpsDebug;
        break;
      case DebugMode.mode3:
        hasAgentVision = !hasAgentVision;
        break;
    }
    print('Debug mode: on');
  }
}

enum DebugMode {
  off,
  mode1, // bodies
  mode2, // fps
  mode3, // agent vision
}
