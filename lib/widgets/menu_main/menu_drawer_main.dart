import 'package:flutter/material.dart';
import 'package:opnot/logic/navigation_functions.dart';
import 'package:opnot/main.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/icon_button_main.dart';

class MenuDrawerMain extends StatelessWidget {
  const MenuDrawerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("built");
    return Drawer(
      child: Text("family"),
    );
  }
}
