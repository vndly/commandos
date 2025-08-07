import 'package:commandos/domain/models/backpack.dart';
import 'package:flame/components.dart';

class Agent {
  final String id;
  final Vector2 position;
  final Backpack backpack;

  Agent({
    required this.id,
    required this.position,
    required this.backpack,
  });
}
