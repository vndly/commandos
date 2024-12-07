import 'package:cavedash/platform/platform_mobile.dart'
    if (dart.library.html) 'package:cavedash/platform/platform_web.dart';

class SetUrlStrategy {
  static void set() => PlatformMethods().urlStrategy();
}
