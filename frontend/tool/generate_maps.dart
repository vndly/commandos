import 'dart:convert';
import 'dart:io';
import 'package:xml2json/xml2json.dart';
import 'json/json_level.dart';
import 'json/json_path.dart';
import 'json/json_position.dart';

typedef Json = Map<String, dynamic>;

void main(List<String> args) async {
  await processFile('tool/input/levels/gym.svg');
}

Future<void> processFile(String filePath) async {
  final File file = File(filePath);
  final Json json = await getJson(file);

  final int width = int.parse(
    (json['svg']['width'] as String).replaceAll('mm', ''),
  );
  final int height = int.parse(
    (json['svg']['height'] as String).replaceAll('mm', ''),
  );
  final List<JsonPath> paths = getPaths(json);

  final JsonLevel level = JsonLevel(
    id: 'Gym',
    width: width,
    height: height,
    paths: paths,
  );
  final String fileName = file.uri.pathSegments.last.split('.')[0];
  writeLevel(fileName: fileName, level: level);
}

Future<Json> getJson(File file) async {
  final String contents = await file.readAsString();

  final Xml2Json xml2json = Xml2Json();
  xml2json.parse(contents);
  final String gdata = xml2json.toGData();

  return jsonDecode(gdata);
}

List<JsonPath> getPaths(Json json) {
  final List<JsonPath> result = [];

  for (final Json g in json['svg']['g']) {
    if (g['id'] == 'paths') {
      for (final Json path in g['path']) {
        final String pathString = path['d'];
        result.add(getPath(pathString: pathString));
      }
    }
  }

  return result;
}

JsonPath getPath({required String pathString}) {
  final RegExp commandRegExp = RegExp(r'[a-zA-Z][^a-zA-Z]*');
  final Iterable<Match> matches = commandRegExp.allMatches(pathString);
  final List<List<double>> coords = [];
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
          coords.add([x, y]);
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
          coords.add([currentX, currentY]);
        }
        break;

      case 'V':
        for (final y in args) {
          currentY = y;
          coords.add([currentX, currentY]);
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

  if (coords.length != 2) {
    throw Exception('Path must have exactly two positions');
  }

  final List<double> pointA = coords[0];
  final List<double> pointB = coords[1];

  if (pointA[0].round() % 5 != 0 ||
      pointA[1].round() % 5 != 0 ||
      pointB[0].round() % 5 != 0 ||
      pointB[1].round() % 5 != 0) {
    throw Exception('Coordinates must be multiples of 5: $pointA, $pointB');
  }

  final JsonPosition a = JsonPosition(
    x: pointA[0].round(),
    y: pointA[1].round(),
  );
  final JsonPosition b = JsonPosition(
    x: pointB[0].round(),
    y: pointB[1].round(),
  );

  return JsonPath(a: a, b: b);
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
