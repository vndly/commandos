import 'dart:convert';
import 'dart:io';
import 'package:xml2json/xml2json.dart';
import 'json/json_behavior.dart';
import 'json/json_level.dart';
import 'json/json_polygon.dart';
import 'json/json_position.dart';
import 'types/behavior_type.dart';
import 'types/door_status.dart';
import 'types/intermittent_state.dart';
import 'types/item_type.dart';
import 'types/rotating_direction.dart';

typedef Json = Map<String, dynamic>;

extension JsonExtensions on Json {
  Json json(String key) => this[key] as Json;

  String string(String key) => this[key] as String;

  String? stringOrNull(String key) => this[key] as String?;

  int integer(String key) => double.parse(string(key)).round();

  int? integerOrNull(String key) =>
      double.tryParse(stringOrNull(key) ?? '')?.round();

  double decimal(String key) => double.parse(string(key));

  double? decimalOrNull(String key) => double.tryParse(stringOrNull(key) ?? '');

  List<Json> list(String key) {
    final dynamic value = this[key];

    if (value is List) {
      return value.cast<Json>();
    } else if (value is Json) {
      return [value];
    } else {
      return [];
    }
  }
}

Future<Json> getJson(String path) async {
  final File file = File(path);
  final String contents = await file.readAsString();

  final Xml2Json xml2json = Xml2Json();
  xml2json.parse(contents);
  final String gdata = xml2json.toGData();

  return jsonDecode(gdata);
}

List<JsonBehavior> getBehaviors(List<Json> json) {
  final List<JsonBehavior> result = [];

  for (final Json item in json) {
    final Json behavior = item.json('behavior');

    result.add(
      JsonBehavior(
        type: parseBehaviorType(behavior.string('type')),
        trigger: behavior.decimalOrNull('trigger'),
        startX: behavior.decimalOrNull('startX'),
        startY: behavior.decimalOrNull('startY'),
        startAngle: behavior.decimalOrNull('startAngle'),
        speed: behavior.decimalOrNull('speed'),
        speedX: behavior.decimalOrNull('speedX'),
        speedY: behavior.decimalOrNull('speedY'),
        centerX: behavior.decimalOrNull('centerX'),
        centerY: behavior.decimalOrNull('centerY'),
        radius: behavior.decimalOrNull('radius'),
        minX: behavior.decimalOrNull('minX'),
        maxX: behavior.decimalOrNull('maxX'),
        minY: behavior.decimalOrNull('minY'),
        maxY: behavior.decimalOrNull('maxY'),
        minAngle: behavior.decimalOrNull('minAngle'),
        maxAngle: behavior.decimalOrNull('maxAngle'),
        periodX: behavior.decimalOrNull('periodX'),
        periodY: behavior.decimalOrNull('periodY'),
        amplitudeX: behavior.decimalOrNull('amplitudeX'),
        amplitudeY: behavior.decimalOrNull('amplitudeY'),
        timeOn: behavior.decimalOrNull('timeOn'),
        timeOff: behavior.decimalOrNull('timeOff'),
        initialTime: behavior.decimalOrNull('initialTime'),
        rotatingDirection: parseRotatingDirection(
          behavior.stringOrNull('rotatingDirection'),
        ),
        intermittentState: parseIntermittentState(
          behavior.stringOrNull('intermittentState'),
        ),
      ),
    );
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

BehaviorType parseBehaviorType(String value) {
  for (final BehaviorType type in BehaviorType.values) {
    if (type.name == value) {
      return type;
    }
  }

  throw Exception('Unknown behavior type: $value');
}

RotatingDirection? parseRotatingDirection(String? value) {
  for (final RotatingDirection type in RotatingDirection.values) {
    if (type.name == value) {
      return type;
    }
  }

  return null;
}

IntermittentState? parseIntermittentState(String? value) {
  for (final IntermittentState type in IntermittentState.values) {
    if (type.name == value) {
      return type;
    }
  }

  return null;
}

JsonPolygon getPolygon(String pathString) {
  final RegExp commandRegExp = RegExp(r'[A-Z][^A-Z]*');
  final Iterable<Match> matches = commandRegExp.allMatches(pathString);
  final List<JsonPosition> vertices = [];
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
          vertices.add(JsonPosition.create(x, y));
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
          vertices.add(JsonPosition.create(currentX, currentY));
        }
        break;

      case 'V':
        for (final y in args) {
          currentY = y;
          vertices.add(JsonPosition.create(currentX, currentY));
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

  return JsonPolygon(vertices: vertices);
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
