import 'package:flame/components.dart';

class Node implements Comparable<Node> {
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

  Node? nodeAt(Vector2 direction) {
    if (direction.x > 0 && right != null) {
      return right;
    } else if (direction.x < 0 && left != null) {
      return left;
    } else if (direction.y > 0 && down != null) {
      return down;
    } else if (direction.y < 0 && up != null) {
      return up;
    } else {
      return null;
    }
  }

  @override
  String toString() => 'Node: ($id, $position)';

  @override
  int compareTo(Node other) {
    if (position == other.position) {
      return 0;
    } else {
      return position.normalize().compareTo(other.position.normalize());
    }
  }
}
