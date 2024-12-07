import 'dart:async';
import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/components/level_component.dart';
import 'package:cavedash/domain/state/game/game_engine.dart';
import 'package:cavedash/domain/state/match/match_state.dart';
import 'package:cavedash/presentation/dialogs/confirmation_dialog.dart';
import 'package:cavedash/utils/navigation.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class GameComponent extends Forge2DGame with GameEngineRef {
  final MatchState matchState;

  GameComponent(this.matchState)
      : super(
          world: LevelComponent(),
          gravity: Vector2(0, 0),
        );

  @override
  FutureOr onLoad() {
    debugMode = false;

    final Size size = MediaQuery.of(Navigation.context()).size;
    final double screenRatio = size.height / size.width;

    const double width = Constants.SCREEN_WIDTH;
    final double height = Constants.SCREEN_WIDTH * screenRatio;

    camera = CameraComponent.withFixedResolution(
      width: width,
      height: height,
    );

    /*camera.moveTo(Vector2(
      Constants.SCREEN_WIDTH / 2,
      (Constants.SCREEN_HEIGHT / 2) - Constants.UI_BASE_HEIGHT,
    ));*/

    if (debugMode) {
      camera.viewport.add(FpsTextComponent(
        position: Vector2(0, 0),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 3,
          ),
        ),
      ));
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Colors.blue; //Palette.GAME_BACKGROUND;

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
