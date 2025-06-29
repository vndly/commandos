import 'dart:async';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/components/level_component.dart';
import 'package:commandos/domain/state/match/level_state.dart';
import 'package:commandos/utils/navigation.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class GameComponent extends Forge2DGame<LevelComponent>
    with HasKeyboardHandlerComponents, PanDetector {
  final MatchState matchState;

  GameComponent({required this.matchState})
    : super(world: LevelComponent(), gravity: Vector2(0, 0));

  @override
  FutureOr onLoad() {
    debugMode = false;

    final Size screenSize = MediaQuery.of(Navigation.context()).size;
    final Size gameSize = _gameSize(screenSize: screenSize);

    camera = CameraComponent.withFixedResolution(
      width: gameSize.width,
      height: gameSize.height,
    );
    camera.moveTo(Constants.MAP_CENTER);

    if (debugMode) {
      camera.viewport.add(
        FpsTextComponent(
          position: Vector2(0, 0),
          anchor: Anchor.topLeft,
          textRenderer: TextPaint(
            style: const TextStyle(color: Colors.white, fontSize: 3),
          ),
        ),
      );
    }

    return super.onLoad();
  }

  Size _gameSize({required Size screenSize}) {
    final Size screenSize = MediaQuery.of(Navigation.context()).size;

    if (screenSize.width > screenSize.height) {
      final double screenRatio = screenSize.height / screenSize.width;

      const double height = Constants.MAP_SIZE_HEIGHT * 1.1;
      final double width = height / screenRatio;

      return Size(width, height);
    } else {
      final double screenRatio = screenSize.width / screenSize.height;

      const double width = Constants.MAP_SIZE_WIDTH * 1.1;
      final double height = width / screenRatio;

      return Size(width, height);
    }
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  @override
  void onPanUpdate(DragUpdateInfo info) =>
      world.characterComponent.onPanUpdate(info);

  void onMatchReset() => matchState.restart();
}
