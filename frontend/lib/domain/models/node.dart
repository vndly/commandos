import 'package:flame/components.dart';

class Node {
  final Vector2 position;
  Node? up;
  Node? down;
  Node? left;
  Node? right;

  Node({
    required this.position,
  });

  void connect({
    Node? up,
    Node? down,
    Node? left,
    Node? right,
  }) {
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;

    if (up != null) {
      up.down = this;
    } else if (down != null) {
      down.up = this;
    } else if (left != null) {
      left.right = this;
    } else if (right != null) {
      right.left = this;
    }
  }
}
