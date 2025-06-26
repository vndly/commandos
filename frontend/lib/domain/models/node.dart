import 'package:flame/components.dart';

class Node {
  final String id;
  final Vector2 position;
  Node? teleportsTo;

  Node({required this.id, required this.position, this.teleportsTo});

  bool get canTeleport => teleportsTo != null;

  @override
  String toString() => 'Node($id): [${position.x}, ${position.y}]';
}
