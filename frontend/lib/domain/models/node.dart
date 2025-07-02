import 'package:flame/components.dart';

class Node {
  final Vector2 position;

  Node({required this.position});

  @override
  String toString() => 'Node: ($position)';
}
