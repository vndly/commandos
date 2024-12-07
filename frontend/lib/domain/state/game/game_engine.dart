import 'package:cavedash/domain/components/game_component.dart';

class GameEngine {
  final GameComponent gameComponent;

  GameEngine({
    required this.gameComponent,
  }) {
    GameEngineRef.instance = this;
  }

  void update(double dt) {}
}

mixin GameEngineRef {
  static late GameEngine instance;

  GameEngine get engine => instance;
}
