import 'dart:convert';
import 'dart:io';
import 'package:cavedash_tools/extensions/num_extension.dart';
import 'package:cavedash_tools/extensions/string_extension.dart';
import 'package:cavedash_tools/extensions/xml_element_extension.dart';
import 'package:cavedash_tools/json/json_behavior.dart';
import 'package:cavedash_tools/json/json_body.dart';
import 'package:cavedash_tools/json/json_fixture.dart';
import 'package:cavedash_tools/json/json_game_object.dart';
import 'package:cavedash_tools/types/behavior_type.dart';
import 'package:cavedash_tools/types/body_type.dart';
import 'package:cavedash_tools/types/intermittent_state.dart';
import 'package:cavedash_tools/types/shape_type.dart';
import 'package:cavedash_tools/types/types.dart';
import 'package:xml/xml.dart';

class BaseGenerator {
  final String folder;

  const BaseGenerator(this.folder);

  List<FileSystemEntity> getFiles() {
    final Directory dir = Directory('input/$folder');
    return dir.listSync();
  }

  XmlDocument document(FileSystemEntity entry) {
    final File file = File(entry.path);
    return XmlDocument.parse(file.readAsStringSync());
  }

  void write(FileSystemEntity entry, Object object) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String json = encoder.convert(object);

    writeJson(entry, json);
    writeDart(entry, json);
  }

  Future generatePNG(FileSystemEntity entry) async {
    final String input = entry.path;
    final String output =
        '../frontend/assets/images/${entry.path.replaceFirst('input/', '').replaceAll('svg', 'png')}';
    await Process.run('inkscape', [
      input,
      '--export-type=png',
      '--export-dpi=25.41',
      '--export-area-drawing',
      '--export-filename=$output',
    ]);
  }

  void writeJson(FileSystemEntity entry, String json) {
    final String fileName = entry.uri.pathSegments.last.split('.')[0];
    final File output = File('output/$folder/$fileName.json');
    output.writeAsStringSync(json);
  }

  void writeDart(FileSystemEntity entry, String json) {
    final String fileName = entry.uri.pathSegments.last.split('.')[0];
    final String className = 'Models${folder.capitalize}${fileName.capitalize}';

    final String content = '''
class $className {
  static const String JSON = \'\'\'
$json
\'\'\';
}
''';

    final File outputDart =
        File('../frontend/lib/assets/$folder/$fileName.dart');
    outputDart.writeAsStringSync(content);
  }

  List<JsonGameObject> getGameObjects(XmlElement xml) {
    final List<JsonGameObject> result = [];

    for (final XmlElement element in xml.childElements) {
      result.add(getGameObject(element));
    }

    return result;
  }

  JsonGameObject getGameObject(XmlElement element) {
    final String id = element.getAttribute('id')!;
    final BodyType bodyType = element.getEnumAttribute(
      'bodyType',
      BodyType.values,
      BodyType.static,
    );
    final num angle = element.getNumAttribute('angle');

    final List<JsonFixture> fixtures = [];
    final List<JsonBehavior> behaviors = [];

    if (element.childElements.isEmpty) {
      fixtures.add(getFixture(element, [0, 0]));
    } else {
      for (final XmlElement child in element.childElements) {
        if ((child.name.local == 'path') || (child.name.local == 'circle')) {
          fixtures.add(getFixture(child, getTranslation(element)));
        }
      }
    }

    num minX = double.infinity;
    num maxX = -double.infinity;
    num minY = double.infinity;
    num maxY = -double.infinity;

    for (final JsonFixture fixture in fixtures) {
      final num localMinX = fixture.minX;
      final num localMaxX = fixture.maxX;
      final num localMinY = fixture.minY;
      final num localMaxY = fixture.maxY;

      if (localMinX < minX) {
        minX = localMinX;
      }

      if (localMaxX > maxX) {
        maxX = localMaxX;
      }

      if (localMinY < minY) {
        minY = localMinY;
      }

      if (localMaxY > maxY) {
        maxY = localMaxY;
      }
    }

    final num x = (minX + maxX) / 2;
    final num y = (minY + maxY) / 2;

    for (final JsonFixture fixture in fixtures) {
      fixture.adjustVertices(x, y);
    }

    for (final XmlElement child in element.childElements) {
      if (child.name.local == 'behavior') {
        behaviors.add(getBehavior(child, x, y));
      }
    }

    return JsonGameObject(
      id: id,
      body: JsonBody(
        type: bodyType,
        x: x.rounded(),
        y: y.rounded(),
        angle: angle.rounded(),
      ),
      fixtures: fixtures,
      behaviors: behaviors,
    );
  }

  JsonFixture getFixture(XmlElement element, Vertex translation) {
    final String id = element.getAttribute('id')!;
    final ShapeType shapeType = element.getEnumAttribute(
      'shapeType',
      ShapeType.values,
      ShapeType.polygon,
    );
    final num radius = element.getNumAttribute('r');

    return JsonFixture(
      id: id,
      shapeType: shapeType,
      vertices: getVertices(element, translation, shapeType),
      radius: radius.rounded(),
    );
  }

  JsonBehavior getBehavior(XmlElement element, num x, num y) {
    final BehaviorType type = element.getEnumAttribute(
      'type',
      BehaviorType.values,
      BehaviorType.rotating,
    );

    num? trigger;
    num startX = x;
    num startY = y;
    num? startAngle;
    num? speed;
    num? speedX;
    num? speedY;
    num centerX = x;
    num centerY = y;
    num? radius;
    num? minX;
    num? maxX;
    num? minY;
    num? maxY;
    num? periodX;
    num? periodY;
    num? amplitudeX;
    num? amplitudeY;
    num? timeOn;
    num? timeOff;
    num? initialTime;
    IntermittentState? intermittentState;

    if (element.hasAttribute('trigger')) {
      trigger = element.getNumAttribute('trigger');
    }

    if (element.hasAttribute('startX')) {
      startX = element.getNumAttribute('startX');
    }

    if (element.hasAttribute('startY')) {
      startY = element.getNumAttribute('startY');
    }

    if (element.hasAttribute('startAngle')) {
      startAngle = element.getNumAttribute('startAngle');
    }

    if (element.hasAttribute('speed')) {
      speed = element.getNumAttribute('speed');
    }

    if (element.hasAttribute('speedX')) {
      speedX = element.getNumAttribute('speedX');
    }

    if (element.hasAttribute('speedY')) {
      speedY = element.getNumAttribute('speedY');
    }

    if (element.hasAttribute('centerX')) {
      centerX = element.getNumAttribute('centerX');
    }

    if (element.hasAttribute('centerY')) {
      centerY = element.getNumAttribute('centerY');
    }

    if (element.hasAttribute('radius')) {
      radius = element.getNumAttribute('radius');
    }

    if (element.hasAttribute('minX')) {
      minX = element.getNumAttribute('minX');
    }

    if (element.hasAttribute('maxX')) {
      maxX = element.getNumAttribute('maxX');
    }

    if (element.hasAttribute('minY')) {
      minY = element.getNumAttribute('minY');
    }

    if (element.hasAttribute('maxY')) {
      maxY = element.getNumAttribute('maxY');
    }

    if (element.hasAttribute('periodX')) {
      periodX = element.getNumAttribute('periodX');
    }

    if (element.hasAttribute('periodY')) {
      periodY = element.getNumAttribute('periodY');
    }

    if (element.hasAttribute('amplitudeX')) {
      amplitudeX = element.getNumAttribute('amplitudeX');
    }

    if (element.hasAttribute('amplitudeY')) {
      amplitudeY = element.getNumAttribute('amplitudeY');
    }

    if (element.hasAttribute('timeOn')) {
      timeOn = element.getNumAttribute('timeOn');
    }

    if (element.hasAttribute('timeOff')) {
      timeOff = element.getNumAttribute('timeOff');
    }

    if (element.hasAttribute('initialTime')) {
      initialTime = element.getNumAttribute('initialTime');
    }

    if (element.hasAttribute('intermittentState')) {
      intermittentState = element.getEnumAttribute(
        'intermittentState',
        IntermittentState.values,
        null,
      );
    }

    return JsonBehavior(
      type: type,
      trigger: trigger,
      startX: startX.rounded(),
      startY: startY.rounded(),
      startAngle: startAngle?.rounded(),
      speed: speed?.rounded(),
      speedX: speedX?.rounded(),
      speedY: speedY?.rounded(),
      centerX: centerX.rounded(),
      centerY: centerY.rounded(),
      radius: radius?.rounded(),
      minX: minX?.rounded(),
      maxX: maxX?.rounded(),
      minY: minY?.rounded(),
      maxY: maxY?.rounded(),
      periodX: periodX?.rounded(),
      periodY: periodY?.rounded(),
      amplitudeX: amplitudeX?.rounded(),
      amplitudeY: amplitudeY?.rounded(),
      timeOn: timeOn?.rounded(),
      timeOff: timeOff?.rounded(),
      initialTime: initialTime?.rounded(),
      intermittentState: intermittentState,
    );
  }

  List<Vertex> getVertices(
    XmlElement element,
    Vertex translation,
    ShapeType shapeType,
  ) {
    if (shapeType == ShapeType.polygon) {
      return getVerticesPolygon(element.getAttribute('d')!, translation);
    } else if (shapeType == ShapeType.circle) {
      return getVerticesCircle(element, translation);
    } else {
      return [];
    }
  }

  List<Vertex> getVerticesCircle(XmlElement element, Vertex translation) {
    final num x = element.getNumAttribute('cx');
    final num y = element.getNumAttribute('cy');

    return [
      [
        (x + translation[0]).rounded(),
        (y + translation[1]).rounded(),
      ]
    ];
  }

  List<Vertex> getVerticesPolygon(String path, Vertex translation) {
    final List<Vertex> result = [];

    String command = '';
    num lastX = 0;
    num lastY = 0;

    for (final String element in path.split(' ')) {
      final String current = element.toUpperCase();

      if ((current == 'M') ||
          (current == 'Z') ||
          (current == 'L') ||
          (current == 'H') ||
          (current == 'V')) {
        command = current;
      } else if ((command == 'M') || (command == 'L')) {
        final List<String> coordinates = current.split(',');
        final num x = num.parse(coordinates[0]);
        final num y = num.parse(coordinates[1]);
        result.add([
          (x + translation[0]).rounded(),
          (y + translation[1]).rounded(),
        ]);

        lastX = x;
        lastY = y;
      } else if (command == 'H') {
        final num value = num.parse(current);
        result.add([
          (value + translation[0]).rounded(),
          (lastY + translation[1]).rounded(),
        ]);

        lastX = value;
      } else if (command == 'V') {
        final num value = num.parse(current);
        result.add([
          (lastX + translation[0]).rounded(),
          (value + translation[1]).rounded(),
        ]);

        lastY = value;
      }
    }

    return result;
  }

  Vertex getTranslation(XmlElement element) {
    final String? transform = element.getAttribute('transform');

    num translateX = 0;
    num translateY = 0;

    if ((transform != null) && transform.startsWith('translate')) {
      final List<String> coordinates =
          transform.replaceAll('translate(', '').replaceAll(')', '').split(',');

      if (coordinates.isNotEmpty) {
        translateX = double.parse(coordinates[0]);
      }

      if (coordinates.length > 1) {
        translateY = double.parse(coordinates[1]);
      }
    }

    return [
      translateX.rounded(),
      translateY.rounded(),
    ];
  }
}
