import 'package:commandos/environments/environment.dart';
import 'package:commandos/utils/audio.dart';
import 'package:commandos/utils/navigation.dart';
import 'package:commandos/utils/platform.dart';
import 'package:commandos/utils/set_url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class Locator {
  static Future load(Environment environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBbB_8eQFJx2Ah4YBKcB6roM8gqRb9Z_Lw',
          authDomain: 'atomic-prototype.firebaseapp.com',
          projectId: 'atomic-prototype',
          storageBucket: 'atomic-prototype.firebasestorage.app',
          messagingSenderId: '1079322227234',
          appId: '1:1079322227234:web:3a79e55e7d553f5abed07b',
          measurementId: 'G-ZRTPXKKG5Y',
        ),
      );
    } else {
      await Firebase.initializeApp();

      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    SetUrlStrategy.set();
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();

    locator.registerSingleton<Environment>(environment);
    locator.registerSingleton<Navigation>(Navigation());
    locator.registerSingleton<Audio>(Audio());

    await environment.configure();
  }
}
