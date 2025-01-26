import 'package:cavedash/domain/components/game_component.dart';
import 'package:dafluta/dafluta.dart';

class MatchState extends BaseState {
  late GameComponent gameComponent;

  MatchState() {
    restart();
  }

  void restart() {
    gameComponent = GameComponent(
      matchState: this,
    );

    notify();
  }
}
