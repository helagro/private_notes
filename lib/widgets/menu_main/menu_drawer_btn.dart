import 'package:flutter/material.dart';
import 'package:opnot/logic/navigation_functions.dart';
import 'package:opnot/main.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/icon_button_main.dart';

class MenuDrawerBtn extends StatelessWidget {
  const MenuDrawerBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButtonMain(
        iconData: Icons.menu,
        onPressed: () {
          print("say ${Scaffold.of(context)}");
          Scaffold.of(context).openDrawer();
        });
  }
}
