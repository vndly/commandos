import 'dart:io';
import 'package:cavedash_tools/generators/base_generator.dart';
import 'package:cavedash_tools/json/json_game_object.dart';
import 'package:xml/xml.dart';

class AvatarsGenerator extends BaseGenerator {
  const AvatarsGenerator() : super('avatars');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);
      final Iterable<XmlElement> elements = xml.findAllElements('g');
      final JsonGameObject gameObject = getGameObject(elements.first);
      write(entry, gameObject);
    }
  }
}
