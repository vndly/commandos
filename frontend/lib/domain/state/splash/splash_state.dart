import 'package:commandos/utils/navigation.dart';
import 'package:dafluta/dafluta.dart';

class SplashState extends BaseState {
  @override
  void onLoad() => onPlay();

  void onPlay() => Navigation.matchScreen();
}
