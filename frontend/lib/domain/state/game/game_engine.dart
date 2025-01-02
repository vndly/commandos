import 'package:cavedash/domain/components/game_component.dart';
import 'package:cavedash/domain/models/grid.dart';

class GameEngine {
  final GameComponent gameComponent;
  final Grid grid;

  GameEngine({
    required this.gameComponent,
    required this.grid,
  }) {
    GameEngineRef.instance = this;
  }

  void update(double dt) {}
}

mixin GameEngineRef {
  static late GameEngine instance;

  GameEngine get engine => instance;
}
