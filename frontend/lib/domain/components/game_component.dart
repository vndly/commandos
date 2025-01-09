import 'dart:async';
import 'package:cavedash/domain/components/level_component.dart';
import 'package:cavedash/domain/models/grid.dart';
import 'package:cavedash/domain/state/match/match_state.dart';
import 'package:cavedash/utils/navigation.dart';
import 'package:cavedash/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class GameComponent extends Forge2DGame<LevelComponent>
    with HasKeyboardHandlerComponents, PanDetector {
  final MatchState matchState;
  final Grid grid;

  GameComponent({
    required this.matchState,
    required this.grid,
  }) : super(
          world: LevelComponent(grid: grid),
          gravity: Vector2(0, 0),
        );

  @override
  FutureOr onLoad() {
    debugMode = false;

    final Size screenSize = MediaQuery.of(Navigation.context()).size;
    final Size gameSize = _gameSize(
      screenSize: screenSize,
      grid: grid,
    );

    camera = CameraComponent.withFixedResolution(
      width: gameSize.width,
      height: gameSize.height,
    );
    camera.moveTo(grid.startPosition);

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

  Size _gameSize({
    required Size screenSize,
    required Grid grid,
  }) {
    final Size screenSize = MediaQuery.of(Navigation.context()).size;

    if (screenSize.width > screenSize.height) {
      final double screenRatio = screenSize.height / screenSize.width;

      final double height = grid.size.y * 1.1;
      final double width = height / screenRatio;

      return Size(width, height);
    } else {
      final double screenRatio = screenSize.width / screenSize.height;

      final double width = grid.size.x * 1.1;
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
