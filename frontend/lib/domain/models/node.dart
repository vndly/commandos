import 'package:flame/components.dart';

class Node implements Comparable<Node> {
  late final String id;
  late final int x;
  late final int y;
  Node? up;
  Node? down;
  Node? left;
  Node? right;

  Node({required Vector2 position}) {
    x = position.x.toInt();
    y = position.y.toInt();
    id = '$x,$y';
  }

  Vector2 get position => Vector2(x.toDouble(), y.toDouble());

  void addConnection(Node node) {
    if ((node.x > x) && (node.y == y)) {
      right = node;
    } else if ((node.x < x) && (node.y == y)) {
      left = node;
    } else if ((node.y > y) && (node.x == x)) {
      down = node;
    } else if ((node.y < y) && (node.x == x)) {
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

  bool inPosition(Vector2 position) {
    return (x == position.x.toInt()) && (y == position.y.toInt());
  }

  @override
  String toString() => 'Node: ($id, $x, $y)';

  @override
  int compareTo(Node other) {
    if ((x == other.x) && (y == other.y)) {
      return 0;
    } else {
      return (x + y).compareTo(other.x + other.y);
    }
  }
}
