import 'package:flame/components.dart';
import 'package:cavedash/domain/state/game/game_engine.dart';

extension ComponentExtension on Component {
  GameEngine get engine => GameEngineRef.instance;
}
