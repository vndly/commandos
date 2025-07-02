import 'package:flame/components.dart';

class Node {
  late final String id;
  final Vector2 position;
  Node? up;
  Node? down;
  Node? left;
  Node? right;

  Node({required this.position}) {
    id = '${position.x.toInt()},${position.y.toInt()}';
  }

  void addConnection(Node node) {
    if ((node.position.x > position.x) && (node.position.y == position.y)) {
      right = node;
    } else if ((node.position.x < position.x) &&
        (node.position.y == position.y)) {
      left = node;
    } else if ((node.position.y > position.y) &&
        (node.position.x == position.x)) {
      down = node;
    } else if ((node.position.y < position.y) &&
        (node.position.x == position.x)) {
      up = node;
    } else {
      throw Exception('Cannot connect nodes: $this to $node');
    }
  }

  @override
  String toString() => 'Node: ($id, $position)';
}
