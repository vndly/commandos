import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/door.dart';
import 'package:commandos/domain/models/item.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/portal.dart';
import 'package:commandos/domain/models/soldier.dart';
import 'package:commandos/domain/models/turret.dart';
import 'package:commandos/domain/models/wall.dart';

class Level {
  final String id;
  final int width;
  final int height;
  final Nodes nodes;
  final List<Portal> portals;
  final List<Agent> agents;
  final List<Turret> turrets;
  final List<Soldier> soldiers;
  final List<Wall> walls;
  final List<Door> doors;
  final List<Item> items;

  const Level({
    required this.id,
    required this.width,
    required this.height,
    required this.nodes,
    required this.portals,
    required this.agents,
    required this.turrets,
    required this.soldiers,
    required this.walls,
    required this.doors,
    required this.items,
  });
}
