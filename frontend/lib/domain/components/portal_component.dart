import 'package:commandos/domain/components/agent_component.dart';
import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/portal.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:commandos/extensions/component_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class PortalComponent extends PhysicalComponent with ContactCallbacks {
  final Portal portal;

  PortalComponent({required this.portal})
    : super(
        position: portal.polygon.position,
        size: portal.polygon.size,
      );

  @override
  Body createBody() => getBodyFromRelativePosition(
    shape: shapePolygon(portal.polygon.vertices),
    center: portal.polygon.position,
    bodyType: BodyType.static,
    group: CollisionGroup.PORTAL,
    angle: 0,
  );

  @override
  void beginContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      level.onEnterPortal(agentComponent: other, portal: portal);
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is AgentComponent) {
      level.onExitPortal(agentComponent: other, portal: portal);
    }
  }
}
