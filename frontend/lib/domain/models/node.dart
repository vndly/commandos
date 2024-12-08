import 'package:flame/components.dart';

class Node {
  final String id;
  final Vector2 position;
  Node? up;
  Node? down;
  Node? left;
  Node? right;

  Node({
    required this.id,
    required this.position,
  });

  void connect({
    Node? up,
    Node? down,
    Node? left,
    Node? right,
  }) {
    if (up != null) {
      this.up = up;
      up.down = this;
    } else if (down != null) {
      this.down = down;
      down.up = this;
    } else if (left != null) {
      this.left = left;
      left.right = this;
    } else if (right != null) {
      this.right = right;
      right.left = this;
    }
  }

  @override
  String toString() => 'Node($id): [${position.x}, ${position.y}]';
}
