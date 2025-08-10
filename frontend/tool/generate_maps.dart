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
  final Json svg = json['svg'];
  final String id = svg.string('id');
  final int width = int.parse(svg.string('width').replaceAll('mm', ''));
  final int height = int.parse(svg.string('height').replaceAll('mm', ''));

  final JsonLevel level = JsonLevel(
    id: id,
    width: width,
    height: height,
    agents: getAgents(json),
    turrets: [],
    soldiers: getSoldiers(json),
    walls: getWalls(json),
    doors: getDoors(json),
    items: getItems(json),
  );

  writeLevel(fileName: id, level: level);
}

List<JsonAgent> getAgents(Json json) {
  final List<JsonAgent> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == 'agents') {
      for (final Json circle in g['circle']) {
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

List<JsonWall> getWalls(Json json) {
  final List<JsonWall> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == 'walls') {
      for (final Json path in g['path']) {
        result.add(
          JsonWall(
            vertices: getPositions(path['d']),
          ),
        );
      }
    }
  }

  return result;
}

List<JsonDoor> getDoors(Json json) {
  final List<JsonDoor> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == 'doors') {
      for (final Json path in g['path']) {
        result.add(
          JsonDoor(
            status: parseDoorStatus(path['status']),
            vertices: getPositions(path['d']),
          ),
        );
      }
    }
  }

  return result;
}

List<JsonItem> getItems(Json json) {
  final List<JsonItem> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == 'items') {
      for (final Json item in g['g']) {
        final String type = item.string('type');
        final Json rect = item['rect'];
        final double x = parseDouble(rect['x']);
        final double y = parseDouble(rect['y']);
        final double width = parseDouble(rect['width']);
        final double height = parseDouble(rect['height']);
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

List<JsonSoldier> getSoldiers(Json json) {
  final List<JsonSoldier> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == 'soldiers') {
      for (final Json circle in g['circle']) {
        final String id = circle.string('id');
        final int cx = circle.integer('cx');
        final int cy = circle.integer('cy');
        final double angle = parseDouble(circle['angle']);
        final double sweep = parseDouble(circle['sweep']);
        final double range = parseDouble(circle['range']);

        result.add(
          JsonSoldier(
            id: id,
            position: JsonPosition(x: cx, y: cy),
            angle: angle,
            sweep: sweep,
            range: range,
            behaviors: getBehaviors(circle['behaviors']),
          ),
        );
      }
    }
  }

  return result;
}
