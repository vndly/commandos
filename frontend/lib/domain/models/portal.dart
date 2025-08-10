import 'package:commandos/domain/models/polygon.dart';

class Portal {
  final Polygon polygon;
  Portal? _destination;

  Portal({
    required this.polygon,
  });

  Portal get destination => _destination!;

  set destination(Portal portal) => _destination = portal;
}
