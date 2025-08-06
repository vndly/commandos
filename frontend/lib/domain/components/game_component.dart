import 'dart:async';
import 'package:commandos/app/debug.dart';
import 'package:commandos/domain/components/level_component.dart';
import 'package:commandos/domain/state/match/level_state.dart';
import 'package:commandos/environments/environment.dart';
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
    final Size gameSize = Dimensions.gameSize();
    camera = CameraComponent.withFixedResolution(
      width: gameSize.width,
      height: gameSize.height,
    );

    if (Environment.get.isDebugMode) {
      camera.viewport.add(
        FpsComponent(),
      );
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  void onLevelRestart() => matchState.restart();
}

mixin GameComponentRef {
  static late GameComponent instance;

  GameComponent get game => instance;
}

class FpsComponent extends PositionComponent {
  FpsTextComponent? fpsTextComponent;
  final Paint paint = Palette.paint(
    style: PaintingStyle.fill,
    color: Colors.black.withAlpha(128),
  );

  FpsComponent()
    : super(
        anchor: Anchor.topLeft,
        position: Vector2(0, 0),
        size: Vector2(16, 8),
      );

  @override
  void update(double dt) {
    super.update(dt);

    if (Debug.hasFpsDebug && (fpsTextComponent == null)) {
      fpsTextComponent = FpsTextComponent(
        position: Vector2(1.4, 1.4),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 4,
          ),
        ),
      );
      add(fpsTextComponent!);
    } else if (!Debug.hasFpsDebug && (fpsTextComponent != null)) {
      remove(fpsTextComponent!);
      fpsTextComponent = null;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (Debug.hasFpsDebug) {
      canvas.drawRect(size.toRect(), paint);
    }
  }
}
