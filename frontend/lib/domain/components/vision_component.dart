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
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.VISION,
    strokeWidth: 0.5,
  );
  final SoldierComponent soldierComponent;
  final List<AgentComponent> agents;
  final List<Beam> beams = [];
  final List<AgentDetectorComponent> agentDetector = [];

  VisionComponent({
    required this.agents,
    required this.soldierComponent,
  }) {
    priority = Priority.vision.value;

    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: -soldierComponent.soldier.sweep,
      ),
    );
    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: soldierComponent.soldier.sweep,
      ),
    );
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    for (final AgentComponent agent in agents) {
      final AgentDetectorComponent agentDetectorComponent =
          AgentDetectorComponent(
            soldierComponent: soldierComponent,
            agentComponent: agent,
          );
      agentDetector.add(agentDetectorComponent);
      await level.add(agentDetectorComponent);
    }
  }

  AgentComponent? refresh({
    required Vector2 source,
    required double angle,
    required RayCasting rayCasting,
  }) {
    for (final Beam beam in beams) {
      final RayCastingResult result = rayCasting.test(
        source: source,
        angle: angle + beam.angle,
        range: soldierComponent.soldier.range,
      );
      beam.update(result);
    }

    AgentComponent? closestAgentDetected;

    for (final AgentDetectorComponent detector in agentDetector) {
      final AgentComponent? detectedAgent = detector.refresh(
        source: source,
        rayCasting: rayCasting,
      );

      if (detectedAgent != null) {
        if (closestAgentDetected == null ||
            source.distanceTo(detectedAgent.body.position) <
                source.distanceTo(closestAgentDetected.body.position)) {
          closestAgentDetected = detectedAgent;
        }
      }
    }

    return closestAgentDetected;
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
  late final Beam beam;
  bool detected = false;

  AgentDetectorComponent({
    required this.soldierComponent,
    required this.agentComponent,
  }) {
    priority = Priority.vision.value;

    beam = Beam(
      start: Vector2.zero(),
      end: Vector2.zero(),
      angle: 0,
    );
  }

  AgentComponent? refresh({
    required Vector2 source,
    required RayCasting rayCasting,
  }) {
    final RayCastingResult result = rayCasting.test(
      source: source,
      angle: source.angle(agentComponent.body.position),
      range: soldierComponent.soldier.range,
    );

    if (_isInFieldOfView(result)) {
      beam.update(result);
      detected = true;
      return agentComponent;
    } else {
      detected = false;
      return null;
    }
  }

  bool _isInFieldOfView(RayCastingResult result) =>
      (result.object is AgentComponent) &&
      soldierComponent.body.position.distanceTo(result.end) <=
          soldierComponent.soldier.range &&
      soldierComponent.inFieldOfView(result.angle);

  @override
  void render(Canvas canvas) {
    if (detected) {
      canvas.drawLine(beam.start.toOffset(), beam.end.toOffset(), paint);
    }
  }
}
