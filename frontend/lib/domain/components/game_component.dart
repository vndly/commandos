import 'dart:async';
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
    debugMode = false;

    final Size gameSize = Dimensions.gameSize();
    camera = CameraComponent.withFixedResolution(
      width: gameSize.width,
      height: gameSize.height,
    );
    camera.moveTo(Vector2.zero());

    if (Environment.get.isDebugMode) {
      camera.viewport.add(
        FpsComponent(position: Vector2(0, 0), size: Vector2(8, 4)),
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
  final Paint paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  FpsComponent({required super.position, required super.size})
    : super(anchor: Anchor.topLeft);

  @override
  FutureOr<void> onLoad() {
    add(
      FpsTextComponent(
        position: Vector2(0.7, 0.7),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
          style: const TextStyle(color: Colors.white, fontSize: 2),
        ),
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), paint);
  }
}
