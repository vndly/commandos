import 'dart:io';
import 'package:tension_tunnel_tools/generators/base_generator.dart';
import 'package:tension_tunnel_tools/json/json_game_object.dart';
import 'package:xml/xml.dart';

class TrailGenerator extends BaseGenerator {
  const TrailGenerator() : super('trail');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);
      final Iterable<XmlElement> elements = xml.findAllElements('path');
      final JsonGameObject gameObject = getGameObject(elements.first);
      write(entry, gameObject);
    }
  }
}
