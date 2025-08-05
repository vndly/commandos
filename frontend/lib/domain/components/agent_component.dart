import 'dart:async';
import 'dart:ui';
import 'package:commandos/app/constants.dart';
import 'package:commandos/app/debug.dart';
import 'package:commandos/domain/components/laser_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/agent.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/input.dart';
import 'package:commandos/domain/models/laser.dart';
import 'package:commandos/domain/types/priority.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:commandos/utils/palette.dart';
import 'package:commandos/utils/ray_casting.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class AgentComponent extends PhysicalComponent {
  final Vector2 velocity = Vector2.zero();
  final Input input;
  final Agent agent;
  late final AgentMovement movement;
  late final LaserComponent laser;
  late final RayCasting rayCasting;
  final Paint paintFill = Palette.paint(
    style: PaintingStyle.fill,
  );
  bool active;

  AgentComponent({
    required super.position,
    required this.input,
    required this.agent,
    required this.active,
  }) : super(size: Vector2(28, 28), priority: Priority.agent.value) {
    movement = AgentMovement(agent: this);
  }

  @override
  Future onLoad() async {
    await super.onLoad();

    rayCasting = RayCasting(world);
    paintFill.color = Constants.AGENT_COLORS[agent.id]!;

    laser = LaserComponent(
      laser: const Laser(
        angle: 0,
        sweep: 22.5,
        range: 0,
        numberOfBeams: 50,
      ),
    );
    await level.add(laser);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (active) {
      movement.update(input);
    }

    if (active && Debug.hasAgentVision) {
      laser.show(
        source: body.position,
        angle: body.angle,
        rayCasting: rayCasting,
      );
    } else {
      laser.hide();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paintFill,
    );
  }

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapeCircle(size * 0.35),
    center: initialPosition,
    bodyType: BodyType.dynamic,
    group: CollisionGroup.AGENT,
    angle: 0,
  );
}

class AgentMovement {
  final AgentComponent agent;

  AgentMovement({
    required this.agent,
  });

  void update(Input input) {
    if (input.hasInput) {
      agent.body.linearVelocity = input.direction * Constants.AGENT_SPEED;
    } else {
      agent.body.linearVelocity = Vector2.zero();
    }
  }
}
