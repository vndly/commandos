import 'dart:async';
import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/components/level_component.dart';
import 'package:cavedash/domain/state/game/game_engine.dart';
import 'package:cavedash/domain/state/match/match_state.dart';
import 'package:cavedash/presentation/dialogs/confirmation_dialog.dart';
import 'package:cavedash/utils/navigation.dart';
import 'package:cavedash/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

class GameComponent extends FlameGame
    with HasCollisionDetection, GameEngineRef {
  final MatchState matchState;

  GameComponent(this.matchState) : super(world: LevelComponent());

  @override
  FutureOr onLoad() {
    camera = CameraComponent.withFixedResolution(
      height: Constants.SCREEN_HEIGHT,
      width: Constants.SCREEN_WIDTH,
    );

    camera.moveTo(Vector2(
      Constants.SCREEN_WIDTH / 2,
      (Constants.SCREEN_HEIGHT / 2) - Constants.UI_BASE_HEIGHT,
    ));

    if (debugMode) {
      add(FpsTextComponent());
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  @override
  void update(double dt) {
    engine.update(dt);

    super.update(dt);
  }

  void onMatchFinished(bool won) {
    pauseEngine();

    if (won) {
      ConfirmationDialog.won(
        onAccept: _onMatchReset,
        onCancel: _onMatchQuit,
      );
    } else {
      ConfirmationDialog.lost(
        onAccept: _onMatchReset,
        onCancel: _onMatchQuit,
      );
    }
  }

  void _onMatchReset() => matchState.restart();

  void _onMatchQuit() => Navigation.pop();
}
