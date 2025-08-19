import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/extensions/vector2_extension.dart';
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
    if (position.around(
      point: Vector2(x + Constants.HALF_GRID, y.toDouble()),
      epsilon: 1,
    )) {
      if ((_objectRight != null) && (_objectRight != object)) {
        throw Exception('Cannot add object: $object to $_objectRight');
      } else {
        _objectRight = object;
      }
    } else if (position.around(
      point: Vector2(x - Constants.HALF_GRID, y.toDouble()),
      epsilon: 1,
    )) {
      if ((_objectLeft != null) && (_objectLeft != object)) {
        throw Exception('Cannot add object: $object to $_objectLeft');
      } else {
        _objectLeft = object;
      }
    } else if (position.around(
      point: Vector2(x.toDouble(), y + Constants.HALF_GRID),
      epsilon: 1,
    )) {
      if ((_objectDown != null) && (_objectDown != object)) {
        throw Exception('Cannot add object: $object to $_objectDown');
      } else {
        _objectDown = object;
      }
    } else if (position.around(
      point: Vector2(x.toDouble(), y - Constants.HALF_GRID),
      epsilon: 1,
    )) {
      if ((_objectUp != null) && (_objectUp != object)) {
        throw Exception('Cannot add object: $object to $_objectUp');
      } else {
        _objectUp = object;
      }
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

  Object? objectAt(AgentOrientation orientation) {
    switch (orientation) {
      case AgentOrientation.up:
        return _objectUp;
      case AgentOrientation.down:
        return _objectDown;
      case AgentOrientation.left:
        return _objectLeft;
      case AgentOrientation.right:
        return _objectRight;
    }
  }

  bool inPosition(Vector2 position) =>
      (x == position.x.toInt()) && (y == position.y.toInt());

  @override
  String toString() => 'Node: ($id, $x, $y)';

  @override
  int compareTo(Node other) => id.compareTo(other.id);
}
