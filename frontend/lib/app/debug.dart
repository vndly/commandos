class Debug {
  static bool hasBodyDebug = false;
  static bool hasFpsDebug = false;
  static bool hasAgentDebug = false;
  static bool hasNodeDebug = false;

  static void set(DebugMode flag) {
    switch (flag) {
      case DebugMode.off:
        hasBodyDebug = false;
        hasFpsDebug = false;
        hasAgentDebug = false;
        hasNodeDebug = false;
        break;
      case DebugMode.mode1:
        hasBodyDebug = !hasBodyDebug;
        break;
      case DebugMode.mode2:
        hasFpsDebug = !hasFpsDebug;
        break;
      case DebugMode.mode3:
        hasAgentDebug = !hasAgentDebug;
        break;
      case DebugMode.mode4:
        hasNodeDebug = !hasNodeDebug;
        break;
    }
  }
}

enum DebugMode {
  off,
  mode1, // bodies
  mode2, // fps
  mode3, // agent vision
  mode4, // node debug
}
