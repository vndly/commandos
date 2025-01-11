import 'dart:io';
import 'package:tension_tunnel_tools/extensions/xml_element_extension.dart';
import 'package:tension_tunnel_tools/generators/base_generator.dart';
import 'package:tension_tunnel_tools/json/json_icon.dart';
import 'package:xml/xml.dart';

class IconsGenerator extends BaseGenerator {
  const IconsGenerator() : super('icons');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);

      final XmlElement root = xml.findAllElements('svg').first;
      final num width = root.getNumAttribute('width');
      final num height = root.getNumAttribute('height');

      final JsonIcon gameObject = getIcon(root, width, height);
      write(entry, gameObject);
    }
  }
}
