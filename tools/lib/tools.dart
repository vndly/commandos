import 'package:cavedash_tools/generators/character_generator.dart';
import 'package:cavedash_tools/generators/level_generator.dart';

void main() {
  const LevelGenerator().run();
  const CharacterGenerator().run();
  //const EnemiesGenerator().run();
}
