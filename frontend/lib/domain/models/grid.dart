import 'package:cavedash/domain/models/input.dart';
import 'package:cavedash/domain/models/node.dart';
import 'package:flame/components.dart';

class Grid {
  final Vector2 size;
  final Vector2 dimensions;
  final List<Node> nodes;
  late final Vector2 startPosition;
  Node currentNode;
  Node? nextNode;

  Grid({
    required this.size,
    required this.dimensions,
    required this.nodes,
    required this.currentNode,
  }) {
    startPosition = currentNode.position;
  }

  Vector2 get center => Vector2(size.x / 2, size.y / 2);

  double get gapX => size.x / (dimensions.x - 1);

  double get gapY => size.y / (dimensions.y - 1);

  bool get isMoving => nextNode != null;

  Vector2? move({
    required InputState state,
    required Vector2 position,
  }) {
    switch (state) {
      case InputState.left:
        nextNode = currentNode.left;
        return (nextNode != null) ? (nextNode!.position - position).normalized() : null;
      case InputState.right:
        nextNode = currentNode.right;
        return (nextNode != null) ? (nextNode!.position - position).normalized() : null;
      case InputState.up:
        nextNode = currentNode.up;
        return (nextNode != null) ? (nextNode!.position - position).normalized() : null;
      case InputState.down:
        nextNode = currentNode.down;
        return (nextNode != null) ? (nextNode!.position - position).normalized() : null;
      default:
        return null;
    }
  }

  double remainingDistance(Vector2 position) {
    if (nextNode == null) {
      return 0;
    } else {
      return position.distanceTo(nextNode!.position);
    }
  }

  void stop() {
    currentNode = nextNode!;
    nextNode = null;
  }

  factory Grid.create() {
    final Vector2 size = Vector2(1000, 1000);
    final Vector2 dimensions = Vector2(7, 7);

    final Map<String, Node> nodes = {};
    final double gapX = size.x / (dimensions.x - 1);
    final double gapY = size.y / (dimensions.y - 1);

    for (int x = 0; x < dimensions.x; x++) {
      for (int y = 0; y < dimensions.y; y++) {
        final Node node = Node(
          id: '$x,$y',
          index: Vector2(
            x.toDouble(),
            y.toDouble(),
          ),
          position: Vector2(
            x * gapX,
            y * gapY,
          ),
        );
        nodes[node.id] = node;
      }
    }

    for (int x = 0; x < dimensions.x; x++) {
      for (int y = 0; y < dimensions.y; y++) {
        final Node node = nodes['$x,$y']!;
        final Node? up = nodes['$x,${y - 1}'];
        final Node? down = nodes['$x,${y + 1}'];
        final Node? left = nodes['${x - 1},$y'];
        final Node? right = nodes['${x + 1},$y'];

        node.connect(
          up: up,
          down: down,
          left: left,
          right: right,
        );
      }
    }

    return Grid(
      size: size,
      dimensions: dimensions,
      nodes: nodes.values.toList(),
      currentNode: nodes['3,3']!,
    );
  }
}
