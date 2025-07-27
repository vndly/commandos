class Debug {
  static DebugMode flag = DebugMode.noDebug;

  static void toggle() {
    flag = DebugMode.values[(DebugMode.values.indexOf(flag) + 1) % DebugMode.values.length];
    print('Debug mode: $flag');
  }

  static bool get hasBodyDebug => flag == DebugMode.bodyDebug;

  static bool get hasFpsDebug => flag == DebugMode.fpsDebug;

  static bool get hasAgentVision => flag == DebugMode.agentVision;
}

enum DebugMode {
  noDebug,
  bodyDebug,
  fpsDebug,
  agentVision,
}
