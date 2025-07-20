import 'package:commandos/domain/components/game_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/wall.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class WallComponent extends BodyComponent<GameComponent> {
  final Wall wall;

  WallComponent({required this.wall});

  @override
  Body createBody() => getBodyFromAbsolutePosition(
    vertices: wall.vertices,
    bodyType: BodyType.static,
    group: CollisionGroup.WALL,
  );

  @override
  void update(double dt) {
    super.update(dt);

    checkDebug();
  }
}
