import 'dart:async';
import 'package:cavedash/domain/components/character_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LevelComponent extends Forge2DWorld {
  LevelComponent();

  @override
  FutureOr onLoad() {
    //final GameEngine engine = GameEngineRef.instance;
    add(CharacterComponent(
      initialPosition: Vector2(0, 0),
      size: Vector2(10, 10),
    ));

    add(DominoBrick(Vector2(20, 20)));

    return super.onLoad();
  }
}

class DominoBrick extends BodyComponent {
  final Vector2 _position;

  DominoBrick(this._position);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(10, 10);
    final fixtureDef = FixtureDef(
      shape,
      density: 25,
      restitution: 0.4,
      friction: 0.5,
    );

    final bodyDef = BodyDef(type: BodyType.dynamic, position: _position);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
