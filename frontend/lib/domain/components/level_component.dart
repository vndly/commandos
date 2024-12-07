import 'dart:async';
import 'package:flame/components.dart';

class LevelComponent extends World {
  LevelComponent();

  @override
  FutureOr onLoad() {
    // final GameEngine engine = GameEngineRef.instance;
    // add(BattlefieldComponent(engine.battlefield));

    return super.onLoad();
  }
}
