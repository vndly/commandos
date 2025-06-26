import 'package:cavedash/app/constants.dart';
import 'package:cavedash/domain/json/json_body.dart';
import 'package:cavedash/domain/json/json_fixture.dart';
import 'package:cavedash/domain/models/portal.dart';
import 'package:cavedash/extensions/body_component_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class PortalComponent extends BodyComponent {
  final String id;
  final JsonBody jsonBody;
  final List<JsonFixture> jsonFixtures;
  final Portal portal;

  PortalComponent({
    required this.id,
    required this.jsonBody,
    required this.jsonFixtures,
    required this.portal,
  });

  @override
  Future onLoad() async {
    await super.onLoad();
    setup();
  }

  void setSensor(bool isSensor) {
    for (final Fixture fixture in body.fixtures) {
      fixture.setSensor(isSensor);
    }
  }

  @override
  Body createBody() {
    final BodyDef bodyDef = BodyDef(
      position: Vector2(
        jsonBody.x / Constants.MAP_GRID_RATIO,
        jsonBody.y / Constants.MAP_GRID_RATIO,
      ),
      type: jsonBody.type,
    );

    final Body body = world.createBody(bodyDef);

    for (final JsonFixture jsonFixture in jsonFixtures) {
      final List<Vector2> vertices = jsonFixture.vertices
          .map(
            (v) => Vector2(
              v[0] / Constants.MAP_GRID_RATIO,
              v[1] / Constants.MAP_GRID_RATIO,
            ),
          )
          .toList();

      final PolygonShape shape = PolygonShape();
      shape.set(vertices);

      final FixtureDef fixtureDef = FixtureDef(
        shape,
        userData: this,
        isSensor: true,
      );

      body.createFixture(fixtureDef);
    }

    return body;
  }
}
