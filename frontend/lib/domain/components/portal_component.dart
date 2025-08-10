import 'package:commandos/domain/components/physical_component.dart';
import 'package:commandos/domain/models/collision_group.dart';
import 'package:commandos/domain/models/portal.dart';
import 'package:commandos/extensions/body_component_extension.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class PortalComponent extends PhysicalComponent {
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
}
