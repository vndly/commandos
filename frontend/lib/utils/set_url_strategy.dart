import 'package:commandos/platform/platform_mobile.dart'
    if (dart.library.js_interop) 'package:commandos/platform/platform_web.dart';

class SetUrlStrategy {
  static void set() => PlatformMethods().urlStrategy();
}
