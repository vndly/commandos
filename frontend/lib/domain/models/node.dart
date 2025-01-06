import 'package:flame/components.dart';

class Node {
  final String id;
  final Vector2 index;
  final Vector2 position;
  Node? up;
  Node? down;
  Node? left;
  Node? right;
  Node? teleportsTo;
  Node? teleportContinuation;

  Node({
    required this.id,
    required this.index,
    required this.position,
    this.teleportsTo,
    this.teleportContinuation,
  });

  bool get canTeleport =>
      (teleportsTo != null) && (teleportContinuation != null);

  void connect({
    Node? up,
    Node? down,
    Node? left,
    Node? right,
  }) {
    if (up != null) {
      this.up = up;
    }

    if (down != null) {
      this.down = down;
    }

    if (left != null) {
      this.left = left;
    }

    if (right != null) {
      this.right = right;
    }
  }

  @override
  String toString() => 'Node($id): [${position.x}, ${position.y}]';
}
