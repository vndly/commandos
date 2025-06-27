import 'package:commandos/domain/state/splash/splash_state.dart';
import 'package:commandos/widgets/game_container.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Center(
        child: ElevatedButton(
          onPressed: state.onPlay,
          child: const Text('PLAY'),
        ),
      ),
    );
  }
}
