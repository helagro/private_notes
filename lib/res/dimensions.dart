import 'package:flutter/material.dart';

class Dimensions {
  static double elevation7 = 1;
  static double elevation6 = 0.7;
  static double elevation5 = 0.5;

  static double tagListWidth = 170;

  static double minWidthForTagList = 900;
  static bool showTagList(BuildContext context) {
    return MediaQuery.of(context).size.width < minWidthForTagList;
  }
}
