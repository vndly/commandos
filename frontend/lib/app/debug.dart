class Debug {
  static const int _NO_DEBUG = 0;
  static const int _BODY_DEBUG = 1;
  static const int _FPS_DEBUG = 2;

  static int flag = _NO_DEBUG;

  static void toggle() {
    flag = (flag + 1) % 3;
    print('Debug mode: $flag');
  }

  static bool get hasBodyDebug => flag == _BODY_DEBUG;

  static bool get hasFpsDebug => flag == _FPS_DEBUG;
}
