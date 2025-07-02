import 'package:commandos/app/constants.dart';
import 'package:commandos/utils/navigation.dart';
import 'package:flutter/material.dart';

class Dimensions {
  static Size gameSize() {
    final Size screenSize = MediaQuery.of(Navigation.context()).size;
    final double screenRatio = screenSize.width / screenSize.height;
    const double height = Constants.UI_HEIGHT;
    final double width = height * screenRatio;

    return Size(width, height);
  }
}
