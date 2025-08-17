class Debug {
  static bool hasFpsDebug = false;
  static bool hasBodyDebug = false;
  static bool hasNodeDebug = false;

  static void set(DebugMode flag) {
    switch (flag) {
      case DebugMode.off:
        hasFpsDebug = false;
        hasBodyDebug = false;
        hasNodeDebug = false;
        break;
      case DebugMode.mode1:
        hasFpsDebug = !hasFpsDebug;
        break;
      case DebugMode.mode2:
        hasBodyDebug = !hasBodyDebug;
        break;
      case DebugMode.mode3:
        hasNodeDebug = !hasNodeDebug;
        break;
    }
  }
}

enum DebugMode {
  off,
  mode1, // fps
  mode2, // bodies
  mode3, // node debug
}
