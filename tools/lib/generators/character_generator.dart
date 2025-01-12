import 'dart:io';
import 'package:cavedash_tools/generators/base_generator.dart';

class CharacterGenerator extends BaseGenerator {
  const CharacterGenerator() : super('characters');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      generatePNG(entry);
    }
  }
}
