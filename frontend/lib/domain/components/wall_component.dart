import 'package:cavedash/extensions/body_component_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class WallComponent extends BodyComponent with ContactCallbacks {
  final Vector2 location;
  final List<Vector2> vertices;

  WallComponent({
    required this.location,
    required this.vertices,
  });

  @override
  Future onLoad() async {
    await super.onLoad();
    setup();
  }

  @override
  Body createBody() {
    final PolygonShape shape = PolygonShape();
    shape.set(vertices);

    final FixtureDef fixtureDef = FixtureDef(
      shape,
      userData: this,
    );

    final BodyDef bodyDef = BodyDef(
      position: location.clone(),
      type: BodyType.static,
    );

    final Body body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is WallComponent) {
      print('beginContact');
    }
  }
}
