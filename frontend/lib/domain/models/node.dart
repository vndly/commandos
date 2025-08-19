import 'package:flame/components.dart';

class Node implements Comparable<Node> {
  late final String id;
  late final int x;
  late final int y;
  Node? _nodeUp;
  Node? _nodeDown;
  Node? _nodeLeft;
  Node? _nodeRight;
  Object? _objectUp;
  Object? _objectDown;
  Object? _objectLeft;
  Object? _objectRight;

  Node({required Vector2 position}) {
    x = position.x.toInt();
    y = position.y.toInt();
    id = '$x,$y';
  }

  Vector2 get position => Vector2(x.toDouble(), y.toDouble());

  void addConnection(Node node) {
    if ((node.x > x) && (node.y == y)) {
      _nodeRight = node;
    } else if ((node.x < x) && (node.y == y)) {
      _nodeLeft = node;
    } else if ((node.y > y) && (node.x == x)) {
      _nodeDown = node;
    } else if ((node.y < y) && (node.x == x)) {
      _nodeUp = node;
    } else {
      throw Exception('Cannot connect nodes: $this to $node');
    }
  }

  void addObject({
    required Object object,
    required Vector2 position,
  }) {
    if ((position.x > x) && (position.y == y)) {
      _objectRight = object;
    } else if ((position.x < x) && (position.y == y)) {
      _objectLeft = object;
    } else if ((position.y > y) && (position.x == x)) {
      _objectDown = object;
    } else if ((position.y < y) && (position.x == x)) {
      _objectUp = object;
    } else {
      throw Exception('Cannot add object: $this to $object');
    }
  }

  Node? nodeAt(Vector2 direction) {
    if (direction.x > 0 && _nodeRight != null) {
      return _nodeRight;
    } else if (direction.x < 0 && _nodeLeft != null) {
      return _nodeLeft;
    } else if (direction.y > 0 && _nodeDown != null) {
      return _nodeDown;
    } else if (direction.y < 0 && _nodeUp != null) {
      return _nodeUp;
    } else {
      return null;
    }
  }

  Object? objectAt(Vector2 direction) {
    if (direction.x > 0 && _objectRight != null) {
      return _objectRight;
    } else if (direction.x < 0 && _objectLeft != null) {
      return _objectLeft;
    } else if (direction.y > 0 && _objectDown != null) {
      return _objectDown;
    } else if (direction.y < 0 && _objectUp != null) {
      return _objectUp;
    } else {
      return null;
    }
  }

  bool inPosition(Vector2 position) =>
      (x == position.x.toInt()) && (y == position.y.toInt());

  @override
  String toString() => 'Node: ($id, $x, $y)';

  @override
  int compareTo(Node other) => id.compareTo(other.id);
}
