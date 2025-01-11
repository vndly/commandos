import 'dart:io';
import 'package:cavedash_tools/generators/base_generator.dart';
import 'package:cavedash_tools/json/json_game_object.dart';
import 'package:cavedash_tools/json/json_level.dart';
import 'package:xml/xml.dart';

class LevelGenerator extends BaseGenerator {
  const LevelGenerator() : super('levels');

  void run() {
    final List<FileSystemEntity> entries = getFiles();
    final List<int> ids = [];

    for (final FileSystemEntity entry in entries) {
      final String fileName = entry.uri.pathSegments.last.split('.')[0];
      final int id = int.parse(fileName.split('_')[1]);
      ids.add(id);

      final XmlDocument xml = document(entry);
      final JsonLevel level = getLevel(xml, id);
      write(entry, level);
    }

    ids.sort((a, b) => a - b);
    _generateMapper(ids);
  }

  JsonLevel getLevel(XmlDocument document, int id) {
    final List<JsonGameObject> walls = [];
    final Iterable<XmlElement> layers = document.findAllElements('g');

    for (final XmlElement layer in layers) {
      final String id = layer.getAttribute('id')!;

      if (id == 'walls') {
        walls.addAll(getGameObjects(layer));
      }
    }

    return JsonLevel(
      id: id,
      walls: walls,
    );
  }

  void _generateMapper(List<int> ids) {
    final List<String> imports = [];
    String mapperContent = '';

    for (final int id in ids) {
      imports
          .add("import 'package:tension_tunnel/assets/levels/level_$id.dart';");

      if (mapperContent.isEmpty) {
        mapperContent += '''
if (level == $id) {
  return ModelsLevelsLevel$id.JSON;
}
''';
      } else {
        mapperContent += '''
 else if (level == $id) {
  return ModelsLevelsLevel$id.JSON;
}
''';
      }
    }

    imports.sort((a, b) => a.compareTo(b));

    final String content = '''
${imports.join('\n')}

class LevelMapper {
  static String byId(int level) {
    $mapperContent
    else {
      throw Error();
    }
  }
}
''';

    final File outputDart =
        File('../frontend/lib/assets/$folder/level_mapper.dart');
    outputDart.writeAsStringSync(content);
  }
}
