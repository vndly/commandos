import 'package:cavedash/domain/components/character_component.dart';
import 'package:cavedash/domain/models/input.dart';
import 'package:cavedash/domain/models/node.dart';
import 'package:flame/components.dart';

class Grid {
  final List<Node> nodes;
  late Node currentNode;
  Node? nextNode;

  Grid({
    required this.nodes,
  }) {
    currentNode = nodes.first;
  }

  bool get isMoving => nextNode != null;

  MovingState move(InputState state) {
    switch (state) {
      case InputState.left:
        nextNode = currentNode.left;
        return (nextNode != null) ? MovingState.left : MovingState.still;
      case InputState.right:
        nextNode = currentNode.right;
        return (nextNode != null) ? MovingState.right : MovingState.still;
      case InputState.up:
        nextNode = currentNode.up;
        return (nextNode != null) ? MovingState.up : MovingState.still;
      case InputState.down:
        nextNode = currentNode.down;
        return (nextNode != null) ? MovingState.down : MovingState.still;
      default:
        return MovingState.still;
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
    final Node node1 = Node(
      id: '1',
      position: Vector2(80, 920),
    );
    final Node node2 = Node(
      id: '2',
      position: Vector2(250, 920),
    );
    final Node node3 = Node(
      id: '3',
      position: Vector2(420, 920),
    );
    final Node node4 = Node(
      id: '4',
      position: Vector2(590, 920),
    );
    final Node node5 = Node(
      id: '5',
      position: Vector2(760, 920),
    );
    final Node node6 = Node(
      id: '6',
      position: Vector2(930, 920),
    );
    final Node node7 = Node(
      id: '7',
      position: Vector2(1440, 920),
    );
    final Node node8 = Node(
      id: '8',
      position: Vector2(1610, 920),
    );
    final Node node9 = Node(
      id: '9',
      position: Vector2(1780, 920),
    );
    final Node node10 = Node(
      id: '10',
      position: Vector2(1950, 920),
    );

    node1.connect(right: node2);
    node2.connect(right: node3);
    node3.connect(right: node4);
    node4.connect(right: node5);
    node5.connect(right: node6);
    node6.connect(right: node7);
    node7.connect(right: node8);
    node8.connect(right: node9);
    node9.connect(right: node10);

    final List<Node> nodes = [
      node1,
      node2,
      node3,
      node4,
      node5,
      node6,
      node7,
      node8,
      node9,
      node10,
    ];

    return Grid(nodes: nodes);
  }
}
