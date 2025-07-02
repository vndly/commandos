import 'dart:convert';
import 'dart:io';
import 'package:commandos/domain/json/json_location.dart';
import 'package:commandos/domain/json/json_path.dart';
import 'package:commandos/domain/json/json_stage.dart';
import 'package:commandos/extensions/string_extension.dart';
import 'package:xml2json/xml2json.dart';

typedef Json = Map<String, dynamic>;

void main(List<String> args) async {
  await processFile('tool/input/levels/gym.svg');
}

Future<void> processFile(String filePath) async {
  final File file = File(filePath);
  final Json json = await getJson(file);
  final List<JsonPath> paths = getPaths(json);

  final JsonStage stage = JsonStage(id: 'Gym', paths: paths);

  final String fileName = file.uri.pathSegments.last.split('.')[0];
  writeLevel(fileName: fileName, level: stage);
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
  final int nodeSize = int.parse(json['svg']['nodeSize']);

  for (final Json g in json['svg']['g']) {
    if (g['id'] == 'paths') {
      for (final Json path in g['path']) {
        final String pathString = path['d'];
        result.add(getPath(pathString: pathString, nodeSize: nodeSize));
      }
    }
  }

  return result;
}

JsonPath getPath({required String pathString, required int nodeSize}) {
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
    throw Exception('Path must have exactly two locations');
  }

  final List<double> pointA = coords[0];
  final List<double> pointB = coords[1];

  final JsonLocation a = JsonLocation(
    x: pointA[0].toInt(),
    y: pointA[1].toInt(),
  );
  final JsonLocation b = JsonLocation(
    x: pointB[0].toInt(),
    y: pointB[1].toInt(),
  );

  return JsonPath(a: a, b: b);
}

void writeLevel({required String fileName, required JsonStage level}) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final String json = encoder.convert(level);
  final String className = 'Lebel${fileName.capitalize}';
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
