import 'package:commandos/domain/state/match/level_state.dart';
import 'package:commandos/raycasting2.dart';
import 'package:commandos/widgets/game_container.dart';
import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatelessWidget {
  final MatchState state;

  const LevelScreen._(this.state);

  factory LevelScreen.instance() => LevelScreen._(MatchState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: StateProvider<MatchState>(
        state: state,
        builder: (context, state) => Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final MatchState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: RaycastExample());
    //GameWidget(game: state.gameComponent);
  }
}
