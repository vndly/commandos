import 'dart:ui';
import 'package:cavedash/app/constants.dart';
import 'package:flame_forge2d/body_component.dart';

extension ComponentExtension on BodyComponent {
  void setup() {
    renderBody = Constants.RENDER_BODIES;

    if (renderBody) {
      paint.color = const Color(0xff00ff00);
      paint.style = PaintingStyle.stroke;
    }
  }
}
