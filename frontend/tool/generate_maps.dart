import 'common.dart';
import 'json/json_agent.dart';
import 'json/json_door.dart';
import 'json/json_item.dart';
import 'json/json_laser.dart';
import 'json/json_level.dart';
import 'json/json_path.dart';
import 'json/json_polygon.dart';
import 'json/json_position.dart';
import 'json/json_soldier.dart';
import 'json/json_turret.dart';
import 'json/json_wall.dart';

void main(List<String> args) async {
  await processFile('tool/input/levels/gym');
}

Future processFile(String levelFolder) async {
  final Json json = await getJson('$levelFolder/level.svg');
  final Json svg = json.json('svg');
  final String id = svg.string('id');
  final int width = int.parse(svg.string('width').replaceAll('mm', ''));
  final int height = int.parse(svg.string('height').replaceAll('mm', ''));

  final JsonLevel level = JsonLevel(
    id: id,
    width: width,
    height: height,
    paths: getPaths(svg),
    portals: getPortals(svg),
    agents: getAgents(svg),
    turrets: getTurrets(svg),
    soldiers: getSoldiers(svg),
    walls: getWalls(svg),
    doors: getDoors(svg),
    items: getItems(svg),
  );

  writeLevel(fileName: id, level: level);
}

List<JsonPath> getPaths(Json svg) {
  final List<JsonPath> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'paths') {
      for (final Json path in g.list('path')) {
        result.add(getPath(path.string('d')));
      }
    }
  }

  return result;
}

List<JsonPath> getPortals(Json svg) {
  final List<JsonPath> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'portals') {
      for (final Json path in g.list('path')) {
        result.add(getPath(path.string('d')));
      }
    }
  }

  return result;
}

JsonPath getPath(String pathString) {
  final JsonPolygon polygon = getPolygon(pathString);

  if (polygon.vertices.length != 2) {
    throw Exception('Path must have exactly two positions');
  }

  return JsonPath(
    a: JsonPosition(
      x: polygon.vertices[0].x,
      y: polygon.vertices[0].y,
    ),
    b: JsonPosition(
      x: polygon.vertices[1].x,
      y: polygon.vertices[1].y,
    ),
  );
}

List<JsonAgent> getAgents(Json svg) {
  final List<JsonAgent> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'agents') {
      for (final Json circle in g.list('circle')) {
        final String id = circle.string('id');
        final double cx = circle.decimal('cx');
        final double cy = circle.decimal('cy');
        result.add(
          JsonAgent(
            id: id,
            position: JsonPosition.create(cx, cy),
          ),
        );
      }
    }
  }

  return result;
}

List<JsonTurret> getTurrets(Json svg) {
  final List<JsonTurret> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'turrets') {
      for (final Json circle in g.list('circle')) {
        final String id = circle.string('id');
        final double cx = circle.decimal('cx');
        final double cy = circle.decimal('cy');
        final double angle = circle.decimal('angle');
        final double range = circle.decimal('range');

        result.add(
          JsonTurret(
            id: id,
            position: JsonPosition.create(cx, cy),
            angle: angle,
            lasers: [
              JsonLaser(
                angle: 0, // TODO(momo): add children tags to add more lasers
                range: range,
              ),
            ],
            behaviors: getBehaviors(circle.list('behaviors')),
          ),
        );
      }
    }
  }

  return result;
}

List<JsonSoldier> getSoldiers(Json svg) {
  final List<JsonSoldier> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'soldiers') {
      for (final Json circle in g.list('circle')) {
        final String id = circle.string('id');
        final double cx = circle.decimal('cx');
        final double cy = circle.decimal('cy');
        final double angle = circle.decimal('angle');
        final double sweep = circle.decimal('sweep');
        final double range = circle.decimal('range');

        result.add(
          JsonSoldier(
            id: id,
            position: JsonPosition.create(cx, cy),
            angle: angle,
            sweep: sweep,
            range: range,
            behaviors: getBehaviors(circle.list('behaviors')),
          ),
        );
      }
    }
  }

  return result;
}

List<JsonWall> getWalls(Json svg) {
  final List<JsonWall> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'walls') {
      for (final Json path in g.list('path')) {
        result.add(
          JsonWall(
            polygon: getPolygon(path.string('d')),
          ),
        );
      }
    }
  }

  return result;
}

List<JsonDoor> getDoors(Json svg) {
  final List<JsonDoor> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'doors') {
      for (final Json path in g.list('path')) {
        result.add(
          JsonDoor(
            status: parseDoorStatus(path.string('status')),
            polygon: getPolygon(path.string('d')),
          ),
        );
      }
    }
  }

  return result;
}

List<JsonItem> getItems(Json svg) {
  final List<JsonItem> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'items') {
      for (final Json item in g.list('g')) {
        final String type = item.string('type');
        final Json rect = item.json('rect');
        final double x = rect.decimal('x');
        final double y = rect.decimal('y');
        final double width = rect.decimal('width');
        final double height = rect.decimal('height');
        result.add(
          JsonItem(
            type: parseItemType(type),
            position: JsonPosition.create(
              x + (width / 2),
              y + (height / 2),
            ),
          ),
        );
      }
    }
  }

  return result;
}
