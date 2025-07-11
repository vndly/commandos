import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/connection.dart';
import 'package:commandos/domain/models/nodes.dart';
import 'package:commandos/domain/models/turret.dart';

class Level {
  final String id;
  final int width;
  final int height;
  final Nodes nodes;
  final List<Agent> agents;
  final List<Turret> turrets;
  final List<Connection> connections;

  const Level({
    required this.id,
    required this.width,
    required this.height,
    required this.nodes,
    required this.agents,
    required this.turrets,
    required this.connections,
  });
}
