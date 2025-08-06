import 'dart:convert';
import 'dart:io';
import 'package:xml2json/xml2json.dart';
import 'json/json_agent.dart';
import 'json/json_door.dart';
import 'json/json_extra.dart';
import 'json/json_item.dart';
import 'json/json_level.dart';
import 'json/json_position.dart';
import 'json/json_wall.dart';
import 'types/door_status.dart';
import 'types/item_type.dart';

typedef Json = Map<String, dynamic>;

typedef Vertex = List<int>;

void main(List<String> args) async {
  await processFile('tool/input/levels/gym');
}

Future processFile(String levelFolder) async {
  final File svgFile = File('$levelFolder/level.svg');
  final Json json = await getJson(svgFile);

  final int width = int.parse(
    (json['svg']['width'] as String).replaceAll('mm', ''),
  );
  final int height = int.parse(
    (json['svg']['height'] as String).replaceAll('mm', ''),
  );
  final List<JsonAgent> agents = getAgents(
    json: json,
    name: 'agents',
  );
  final List<JsonWall> walls = getWalls(
    json: json,
    name: 'walls',
  );
  final List<JsonDoor> doors = getDoors(
    json: json,
    name: 'doors',
  );
  final List<JsonItem> items = getItems(
    json: json,
    name: 'items',
  );

  final File jsonFile = File('$levelFolder/level.json');
  final String extra = await jsonFile.readAsString();
  final JsonExtra jsonExtra = JsonExtra.fromString(extra);

  final String levelId = jsonExtra.id;

  final JsonLevel level = JsonLevel(
    id: levelId,
    width: width,
    height: height,
    agents: agents,
    turrets: jsonExtra.turrets,
    soldiers: jsonExtra.soldiers,
    walls: walls,
    doors: doors,
    items: items,
  );

  writeLevel(fileName: levelId, level: level);
}

Future<Json> getJson(File file) async {
  final String contents = await file.readAsString();

  final Xml2Json xml2json = Xml2Json();
  xml2json.parse(contents);
  final String gdata = xml2json.toGData();

  return jsonDecode(gdata);
}

List<JsonAgent> getAgents({
  required Json json,
  required String name,
}) {
  final List<JsonAgent> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == name) {
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

List<JsonWall> getWalls({
  required Json json,
  required String name,
}) {
  final List<JsonWall> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == name) {
      for (final Json path in g['path']) {
        final String pathString = path['d'];
        final List<JsonPosition> vertices = getPositions(pathString);
        result.add(JsonWall(vertices: vertices));
      }
    }
  }

  return result;
}

List<JsonDoor> getDoors({
  required Json json,
  required String name,
}) {
  final List<JsonDoor> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == name) {
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

List<JsonItem> getItems({
  required Json json,
  required String name,
}) {
  final List<JsonItem> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == name) {
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

ItemType parseItemType(String value) {
  for (final ItemType type in ItemType.values) {
    if (type.name == value) {
      return type;
    }
  }

  throw Exception('Unknown item type: $value');
}

DoorStatus parseDoorStatus(String value) {
  for (final DoorStatus type in DoorStatus.values) {
    if (type.name == value) {
      return type;
    }
  }

  throw Exception('Unknown item type: $value');
}

List<JsonPosition> getPositions(String pathString) {
  final RegExp commandRegExp = RegExp(r'[A-Z][^A-Z]*');
  final Iterable<Match> matches = commandRegExp.allMatches(pathString);
  final List<JsonPosition> result = [];
  double startX = 0;
  double startY = 0;
  double currentX = 0;
  double currentY = 0;

  for (final Match match in matches) {
    final String command = match.group(0)!;
    final String type = command[0];
    final List<double> args = command
        .substring(1)
        .trim()
        .split(RegExp(r'[\s,]+'))
        .where((s) => s.isNotEmpty)
        .map(double.parse)
        .toList();

    switch (type) {
      case 'M':
      case 'L':
        for (int i = 0; i < args.length; i += 2) {
          final double x = args[i];
          final double y = args[i + 1];
          result.add(JsonPosition(x: x.round(), y: y.round()));
          currentX = x;
          currentY = y;
          if (type == 'M') {
            startX = x;
            startY = y;
          }
        }
        break;

      case 'H':
        for (final x in args) {
          currentX = x;
          result.add(JsonPosition(x: currentX.round(), y: currentY.round()));
        }
        break;

      case 'V':
        for (final y in args) {
          currentY = y;
          result.add(JsonPosition(x: currentX.round(), y: currentY.round()));
        }
        break;

      case 'Z':
      case 'z':
        currentX = startX;
        currentY = startY;
        break;

      default:
        throw Exception('Unsupported command: $type');
    }
  }

  return result;
}

void writeLevel({required String fileName, required JsonLevel level}) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final String json = encoder.convert(level);
  final String className = 'Level${capitalize(fileName)}';
  final String content =
      '''
class $className {
  static const String JSON = \'\'\'
$json
\'\'\';
}
''';

  final File outputDart = File('../frontend/lib/assets/levels/$fileName.dart');
  outputDart.writeAsStringSync(content);
}

String capitalize(String value) =>
    '${value[0].toUpperCase()}${value.substring(1)}';
