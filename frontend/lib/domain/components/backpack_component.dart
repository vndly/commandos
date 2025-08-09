import 'package:commandos/domain/components/level_component.dart';
import 'package:flame/components.dart';

class VisionComponent extends PositionComponent {
  final LevelComponent levelComponent;

  VisionComponent({
    required this.levelComponent,
  });

  @override
  Future onLoad() async {
    await super.onLoad();
  }
}
