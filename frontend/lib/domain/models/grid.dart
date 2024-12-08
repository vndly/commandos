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

  factory Grid.create() {
    final Node node1 = Node(position: Vector2(10, 110));
    final Node node2 = Node(position: Vector2(30, 110));
    final Node node3 = Node(position: Vector2(50, 110));
    final Node node4 = Node(position: Vector2(70, 110));
    final Node node5 = Node(position: Vector2(90, 110));
    final Node node6 = Node(position: Vector2(170, 110));
    final Node node7 = Node(position: Vector2(190, 110));
    final Node node8 = Node(position: Vector2(210, 110));
    final Node node9 = Node(position: Vector2(230, 110));

    node1.connect(right: node2);
    node2.connect(right: node3);
    node3.connect(right: node4);
    node4.connect(right: node5);
    node5.connect(right: node6);
    node6.connect(right: node7);
    node7.connect(right: node8);
    node8.connect(right: node9);

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
    ];

    return Grid(nodes: nodes);
  }
}
