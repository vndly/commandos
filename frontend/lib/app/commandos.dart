import 'package:commandos/presentation/splash/splash_screen.dart';
import 'package:commandos/utils/navigation.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flutter/material.dart';

class Commandos extends StatelessWidget {
  const Commandos();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commandos',
      debugShowCheckedModeBanner: false,
      navigatorKey: Navigation.get.routes.key,
      theme: ThemeData(
        primaryColor: Palette.primary,
        primarySwatch: Palette.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.primary),
        scaffoldBackgroundColor: Palette.GAME_BACKGROUND,
      ),
      home: SplashScreen.instance(),
    );
  }
}
