import 'package:cavedash/domain/models/node.dart';

class Portal {
  final Node nodeA;
  final Node nodeB;

  const Portal({
    required this.nodeA,
    required this.nodeB,
  });
}
