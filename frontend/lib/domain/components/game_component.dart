import 'dart:async';
import 'package:commandos/domain/components/level_component.dart';
import 'package:commandos/domain/state/match/level_state.dart';
import 'package:commandos/utils/dimensions.dart';
import 'package:commandos/utils/palette.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class GameComponent extends Forge2DGame<LevelComponent>
    with HasKeyboardHandlerComponents {
  final MatchState matchState;

  GameComponent({required this.matchState})
    : super(world: LevelComponent(), gravity: Vector2(0, 0)) {
    GameComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    debugMode = false;

    final Size gameSize = Dimensions.gameSize();
    camera = CameraComponent.withFixedResolution(
      width: gameSize.width,
      height: gameSize.height,
    );
    camera.moveTo(Vector2.zero());

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

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  void onMatchReset() => matchState.restart();
}

mixin GameComponentRef {
  static late GameComponent instance;

  GameComponent get game => instance;
}
