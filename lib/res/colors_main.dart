import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsMain {
  static const Color textColor = Color.fromARGB(255, 47, 47, 47);
  static const Color textColorElevated = Color.fromARGB(255, 66, 66, 66);
  static const Color detailColor = Color.fromARGB(255, 201, 201, 201);
  static const Color darkBackground = Color.fromARGB(255, 230, 230, 230);
  static const Color primary = Color.fromARGB(255, 152, 76, 18);
  static final Color primaryB9 = newBrightness(primary, 200);
  static const Color background = Color.fromARGB(255, 240, 240, 240);
  static const Color primaryContainer = Color.fromARGB(255, 248, 248, 248);
  static const Color secondaryContainer = Color.fromARGB(255, 253, 253, 253);
  static const Color tertiaryContainer = Color(0xffffffff);

  static Color newBrightness(Color color, int brightness) {
    return Color.alphaBlend(
        Color.fromARGB(125, brightness, brightness, brightness), color);
  }
}
