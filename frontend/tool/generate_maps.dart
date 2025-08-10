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

  final String id = json['svg']['id'] as String;
  final int width = int.parse(
    (json['svg']['width'] as String).replaceAll('mm', ''),
  );
  final int height = int.parse(
    (json['svg']['height'] as String).replaceAll('mm', ''),
  );

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
        final String id = circle['id'];
        final int cx = double.parse(circle['cx'] as String).round();
        final int cy = double.parse(circle['cy'] as String).round();
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
        final String pathString = path['d'];
        final List<JsonPosition> vertices = getPositions(pathString);
        result.add(JsonWall(vertices: vertices));
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
        final String pathString = path['d'];
        final List<JsonPosition> vertices = getPositions(pathString);
        result.add(
          JsonDoor(
            status: parseDoorStatus(path['status']),
            vertices: vertices,
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
        final String type = item['type'];
        final Json rect = item['rect'];
        final double x = double.parse(rect['x']);
        final double y = double.parse(rect['y']);
        final double width = double.parse(rect['width']);
        final double height = double.parse(rect['height']);
        result.add(
          JsonItem(
            type: parseItemType(type),
            position: JsonPosition(
              x: (x + (width / 2)).toInt(),
              y: (y + (height / 2)).toInt(),
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
        final String id = circle['id'];
        final int cx = double.parse(circle['cx'] as String).round();
        final int cy = double.parse(circle['cy'] as String).round();
        final double angle = double.parse(circle['angle'] as String);
        final double sweep = double.parse(circle['sweep'] as String);
        final double range = double.parse(circle['range'] as String);

        result.add(
          JsonSoldier(
            id: id,
            position: JsonPosition(x: cx, y: cy),
            angle: angle,
            sweep: sweep,
            range: range,
            behaviors: [],
          ),
        );
      }
    }
  }

  return result;
}
