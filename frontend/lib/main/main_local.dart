import 'dart:async';
import 'package:commandos/app/commandos.dart';
import 'package:commandos/environments/environment_local.dart';
import 'package:commandos/utils/error_handler.dart';
import 'package:commandos/utils/locator.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    await Locator.load(LocalEnvironment());
    runApp(const Commandos());
  }, ErrorHandler.onUncaughtError);
}
