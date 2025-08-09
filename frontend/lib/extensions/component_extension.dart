import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/components/level_component.dart';
import 'package:flame/components.dart';

extension ComponentExtension on Component {
  GameComponent get game => GameComponentRef.instance;

  LevelComponent get level => LevelComponentRef.instance;

  CameraComponent get camera => game.camera;
}
