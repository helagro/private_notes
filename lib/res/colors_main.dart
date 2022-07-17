import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsMain {
  static Color textColor = Color.fromARGB(255, 47, 47, 47);
  static Color textColorElevated = Color.fromARGB(255, 66, 66, 66);
  static Color darkBackground = Color.fromARGB(255, 230, 230, 230);
  static Color primary = Color.fromARGB(255, 152, 76, 18);
  static Color primaryB9 = newBrightness(primary, 200);
  static Color background = Color.fromARGB(255, 240, 240, 240);
  static Color primaryContainer = Color.fromARGB(255, 248, 248, 248);
  static Color secondaryContainer = Color.fromARGB(255, 253, 253, 253);
  static Color tertiaryContainer = const Color(0xffffffff);

  static Color newBrightness(Color color, int brightness) {
    return Color.alphaBlend(
        Color.fromARGB(125, brightness, brightness, brightness), color);
  }
}
