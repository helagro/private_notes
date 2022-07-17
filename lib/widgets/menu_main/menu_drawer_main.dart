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
      width: 200,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: const [
            TextButton(
                onPressed: NavigationFunctions.goToSettings,
                child: Text("Settings")),
            TextButton(
                onPressed: NavigationFunctions.logOut, child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}
