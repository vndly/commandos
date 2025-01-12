import 'dart:io';
import 'package:cavedash_tools/generators/base_generator.dart';
import 'package:cavedash_tools/json/json_game_object.dart';
import 'package:cavedash_tools/json/json_level.dart';
import 'package:xml/xml.dart';

class LevelGenerator extends BaseGenerator {
  const LevelGenerator() : super('levels');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final String fileName = entry.uri.pathSegments.last.split('.')[0];
      final int id = int.parse(fileName.split('_')[1]);

      final XmlDocument xml = document(entry);
      final JsonLevel level = getLevel(xml, id);
      write(entry, level);
    }
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
}
