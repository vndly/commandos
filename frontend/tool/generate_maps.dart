import 'common.dart';
import 'json/json_agent.dart';
import 'json/json_door.dart';
import 'json/json_item.dart';
import 'json/json_level.dart';
import 'json/json_position.dart';
import 'json/json_soldier.dart';
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
    agents: getAgents(svg),
    turrets: [],
    soldiers: getSoldiers(svg),
    walls: getWalls(svg),
    doors: getDoors(svg),
    items: getItems(svg),
  );

  writeLevel(fileName: id, level: level);
}

List<JsonAgent> getAgents(Json svg) {
  final List<JsonAgent> result = [];

  for (final Json g in svg.list('g')) {
    if (g.string('id') == 'agents') {
      for (final Json circle in g.list('circle')) {
        final String id = circle.string('id');
        final int cx = circle.integer('cx');
        final int cy = circle.integer('cy');
        result.add(
          JsonAgent(
            id: id,
            position: JsonPosition(x: cx, y: cy),
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
            vertices: getPositions(path.string('d')),
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
            vertices: getPositions(path.string('d')),
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
            position: JsonPosition(
              x: (x + (width / 2)).round(),
              y: (y + (height / 2)).round(),
            ),
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
        final int cx = circle.integer('cx');
        final int cy = circle.integer('cy');
        final double angle = circle.decimal('angle');
        final double sweep = circle.decimal('sweep');
        final double range = circle.decimal('range');

        result.add(
          JsonSoldier(
            id: id,
            position: JsonPosition(x: cx, y: cy),
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
