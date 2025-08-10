import 'package:commandos/domain/models/polygon.dart';

class Portal {
  final String id;
  final Polygon polygon;
  Portal? _destination;

  Portal({
    required this.id,
    required this.polygon,
  });

  Portal get destination => _destination!;

  set destination(Portal portal) => _destination = portal;
}
