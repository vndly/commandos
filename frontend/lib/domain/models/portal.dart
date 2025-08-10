import 'package:commandos/domain/models/polygon.dart';

class Portal {
  final String id;
  final Polygon entrance;
  final Polygon exit;

  const Portal({
    required this.id,
    required this.entrance,
    required this.exit,
  });
}
