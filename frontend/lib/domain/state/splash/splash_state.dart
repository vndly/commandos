import 'package:commandos/utils/audio.dart';
import 'package:commandos/utils/navigation.dart';
import 'package:dafluta/dafluta.dart';

class SplashState extends BaseState {
  @override
  Future onLoad() async {
    await Audio.get.load();
    onPlay();
  }

  void onPlay() => Navigation.matchScreen();
}
