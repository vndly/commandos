import 'dart:ui';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/soldier_component.dart';
import 'package:commandos/domain/models/beam.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/extensions/vector2_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';

class VisionComponent extends Component {
  final double sweep;
  final double range;
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.VISION,
    strokeWidth: 0.2,
  );
  final SoldierComponent soldierComponent;
  final List<AgentComponent> agents;
  final List<Beam> beams = [];
  final List<AgentDetectorComponent> debugVision = [];

  VisionComponent({
    required this.sweep,
    required this.range,
    required this.agents,
    required this.soldierComponent,
  }) {
    priority = Priority.vision.value;

    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: -sweep,
      ),
    );
    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: sweep,
      ),
    );
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    for (final AgentComponent agent in agents) {
      final AgentDetectorComponent debugVisionComponent =
          AgentDetectorComponent(
            soldierComponent: soldierComponent,
            agentComponent: agent,
            range: range,
          );
      debugVision.add(debugVisionComponent);
      await level.add(debugVisionComponent);
    }
  }

  void refresh({
    required Vector2 source,
    required double angle,
    required RayCasting rayCasting,
  }) {
    for (final Beam beam in beams) {
      final RayCastingResult result = rayCasting.test(
        source: source,
        angle: angle + beam.angle,
        gap: 0,
        length: range != 0 ? range : 1000,
      );
      beam.update(result);
    }

    for (final AgentDetectorComponent debugVision in debugVision) {
      debugVision.refresh(
        source: source,
        rayCasting: rayCasting,
      );
    }
  }

  @override
  void render(Canvas canvas) {
    for (final Beam beam in beams) {
      canvas.drawLine(beam.start.toOffset(), beam.end.toOffset(), paint);
    }
  }
}

class AgentDetectorComponent extends Component {
  final SoldierComponent soldierComponent;
  final AgentComponent agentComponent;
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.DETECTED,
    strokeWidth: 0.5,
  );
  final double range;
  late final Beam beam;
  bool detected = false;

  AgentDetectorComponent({
    required this.soldierComponent,
    required this.agentComponent,
    required this.range,
  }) {
    priority = Priority.vision.value;

    beam = Beam(
      start: Vector2.zero(),
      end: Vector2.zero(),
      angle: 0,
    );
  }

  void refresh({
    required Vector2 source,
    required RayCasting rayCasting,
  }) {
    final RayCastingResult result = rayCasting.test(
      source: source,
      angle: source.angle(agentComponent.body.position),
      gap: 0,
      length: range,
    );

    if (isInFieldOfView(result: result)) {
      beam.update(result);
      detected = true;
    } else {
      detected = false;
    }
  }

  bool isInFieldOfView({
    required RayCastingResult result,
  }) {
    return (result.object is AgentComponent) &&
        soldierComponent.body.position.distanceTo(result.end) <=
            soldierComponent.soldier.range &&
        soldierComponent.inFieldOfView(result.angle);
  }

  @override
  void render(Canvas canvas) {
    if (detected) {
      canvas.drawLine(beam.start.toOffset(), beam.end.toOffset(), paint);
    }
  }
}
