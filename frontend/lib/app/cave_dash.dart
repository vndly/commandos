import 'package:cavedash/presentation/splash/splash_screen.dart';
import 'package:cavedash/utils/navigation.dart';
import 'package:cavedash/utils/palette.dart';
import 'package:flutter/material.dart';

class CaveDash extends StatelessWidget {
  const CaveDash();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cave Dash',
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
