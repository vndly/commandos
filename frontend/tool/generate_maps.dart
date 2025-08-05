import 'dart:convert';
import 'dart:io';
import 'package:xml2json/xml2json.dart';
import 'json/json_agent.dart';
import 'json/json_extra.dart';
import 'json/json_item.dart';
import 'json/json_level.dart';
import 'json/json_position.dart';
import 'json/json_wall.dart';
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
        result.add(getWall(pathString));
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
        final Json rect = item['rect'];
        final double x = double.parse(rect['x']);
        final double y = double.parse(rect['y']);
        final double width = double.parse(rect['width']);
        final double height = double.parse(rect['height']);
        result.add(
          JsonItem(
            type: ItemType.keycard, // parseItemType(g['type'])!,
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

/*ItemType? parseItemType(String value) => Enums.parse(
  value: value,
  list: ItemType.values,
  mapper: (e) => e.name,
);*/

JsonWall getWall(String wallString) {
  final List<Vertex> coords = getCoordinates(wallString);

  if (coords.length != 4) {
    throw Exception('Wall must have exactly two positions');
  }

  final Vertex pointA = coords[0];
  final Vertex pointB = coords[1];
  final Vertex pointC = coords[2];
  final Vertex pointD = coords[3];

  return JsonWall(
    vertices: [
      JsonPosition(
        x: pointA[0],
        y: pointA[1],
      ),
      JsonPosition(
        x: pointB[0],
        y: pointB[1],
      ),
      JsonPosition(
        x: pointC[0],
        y: pointC[1],
      ),
      JsonPosition(
        x: pointD[0],
        y: pointD[1],
      ),
    ],
  );
}

List<Vertex> getCoordinates(String pathString) {
  final RegExp commandRegExp = RegExp(r'[A-Z][^A-Z]*');
  final Iterable<Match> matches = commandRegExp.allMatches(pathString);
  final List<Vertex> result = [];
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
          result.add([x.round(), y.round()]);
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
          result.add([currentX.round(), currentY.round()]);
        }
        break;

      case 'V':
        for (final y in args) {
          currentY = y;
          result.add([currentX.round(), currentY.round()]);
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
