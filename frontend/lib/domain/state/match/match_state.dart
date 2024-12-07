import 'package:cavedash/domain/components/game_component.dart';
import 'package:cavedash/domain/state/game/game_engine.dart';
import 'package:dafluta/dafluta.dart';

class MatchState extends BaseState {
  late GameComponent gameComponent;
  late GameEngine engine;

  MatchState() {
    restart();
  }

  void restart() {
    gameComponent = GameComponent(this);
    engine = GameEngine(gameComponent: gameComponent);

    notify();
  }
}
