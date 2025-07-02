import 'package:flame/components.dart';

class Node {
  final String id;
  final Vector2 position;

  Node({required this.id, required this.position});

  @override
  String toString() => 'Node($id): [${position.x}, ${position.y}]';
}
