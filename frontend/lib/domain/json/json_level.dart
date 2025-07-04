import 'package:commandos/domain/models/node.dart';
import 'package:flame/components.dart';
import 'package:json_annotation/json_annotation.dart';
import 'json_path.dart';

part 'json_level.g.dart';

@JsonSerializable()
class JsonLevel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'width')
  final int width;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'paths')
  final List<JsonPath> paths;

  const JsonLevel({
    required this.id,
    required this.width,
    required this.height,
    required this.paths,
  });

  factory JsonLevel.fromJson(Map<String, dynamic> json) =>
      _$JsonLevelFromJson(json);

  List<Node> get nodes {
    final Map<String, Node> result = {};

    for (final JsonPath path in paths) {
      final Node nodeA = _addNode(result: result, position: path.a.vector2);
      final Node nodeB = _addNode(result: result, position: path.b.vector2);

      nodeA.addConnection(nodeB);
      nodeB.addConnection(nodeA);
    }

    return result.values.toList();
  }

  Node _addNode({
    required Map<String, Node> result,
    required Vector2 position,
  }) {
    final String id = '${position.x.toInt()},${position.y.toInt()}';

    if (result.containsKey(id)) {
      return result[id]!;
    } else {
      final Node node = Node(position: position);
      result[id] = node;

      return node;
    }
  }

  Map<String, dynamic> toJson() => _$JsonLevelToJson(this);
}
