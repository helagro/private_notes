import 'package:flutter/material.dart';
import 'package:opnot/res/dimensions.dart';

import '../icon_button_main.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 4),
      shape: const ContinuousRectangleBorder(),
      elevation: Dimensions.elevation7,
      child: Container(
        padding: const EdgeInsets.all(2),
        child: Row(children: children),
      ),
    );
  }
}
