import 'dart:ui';
import 'package:commandos/app/constants.dart';
import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/models/beam.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/presentation/audio/audio.dart';
import 'package:commandos/presentation/audio/sound.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame/components.dart';

class LaserComponent extends Component {
  final Laser laser;
  final Paint paint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.LASER,
    strokeWidth: 0.5,
  );
  final List<Beam> beams = [];
  AgentComponent? agentInVision;
  bool enabled = true;

  LaserComponent({
    required this.laser,
  }) {
    priority = Priority.laser.value;

    beams.add(
      Beam(
        start: Vector2.zero(),
        end: Vector2.zero(),
        angle: radians(-90),
      ),
    );
  }

  void refresh({
    required double dt,
    required Vector2 source,
    required double angle,
    required RayCasting rayCasting,
  }) {
    AgentComponent? newAgentDetected;

    for (final Beam beam in beams) {
      final RayCastingResult result = rayCasting.test(
        source: source,
        angle: angle + laser.angle + beam.angle,
        range: laser.range != 0 ? laser.range : 1000,
      );
      beam.update(result);

      if (result.object is AgentComponent) {
        newAgentDetected = result.object as AgentComponent;

        final double score = (1 - (result.distance / laser.range)).clamp(0, 1);
        level.onAgentSpotted(dt * Constants.ALARM_RATIO_SOLDIER * score);

        if (agentInVision == null) {
          Audio.get.playSound(Sound.DETECTION);
        }
        break;
      }
    }

    agentInVision = newAgentDetected;
    enabled = true;
  }

  void disable() {
    enabled = false;
  }

  @override
  void render(Canvas canvas) {
    if (enabled) {
      for (final Beam beam in beams) {
        canvas.drawLine(beam.start.toOffset(), beam.end.toOffset(), paint);
      }
    }
  }
}
