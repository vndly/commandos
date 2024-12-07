import 'package:dafluta/dafluta.dart';
import 'package:cavedash/utils/navigation.dart';

class SplashState extends BaseState {
  @override
  void onLoad() => onPlay();

  void onPlay() => Navigation.matchScreen();
}
