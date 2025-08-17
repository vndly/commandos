import 'package:commandos/domain/models/node.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Nodes extends Iterable<Node> {
  final List<Node> nodes;

  Nodes({required this.nodes});

  Node nodeAt(Vector2 position) {
    for (final Node node in nodes) {
      if (node.position == position) {
        return node;
      }
    }
    throw Exception('Node not found for position: $position');
  }

  @override
  Iterator<Node> get iterator => nodes.iterator;
}
