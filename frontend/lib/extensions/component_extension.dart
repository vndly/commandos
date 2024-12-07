import 'package:cavedash/domain/state/game/game_engine.dart';
import 'package:flame/components.dart';

extension ComponentExtension on Component {
  GameEngine get engine => GameEngineRef.instance;
}
