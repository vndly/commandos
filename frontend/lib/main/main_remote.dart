import 'dart:async';
import 'package:cavedash/app/cave_dash.dart';
import 'package:cavedash/environments/environment_remote.dart';
import 'package:cavedash/utils/error_handler.dart';
import 'package:cavedash/utils/locator.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    await Locator.load(RemoteEnvironment());
    runApp(const CaveDash());
  }, ErrorHandler.onUncaughtError);
}
