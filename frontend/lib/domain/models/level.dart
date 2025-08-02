import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';

class Level {
  final String id;
  final int width;
  final int height;
  final List<Agent> agents;
  final List<Turret> turrets;
  final List<Soldier> soldiers;
  final List<Wall> walls;
  final List<Item> items;

  const Level({
    required this.id,
    required this.width,
    required this.height,
    required this.agents,
    required this.turrets,
    required this.soldiers,
    required this.walls,
    required this.items,
  });
}
