import 'package:flutter/material.dart';
import 'package:opnot/logic/navigation_functions.dart';
import 'package:opnot/res/colors_main.dart';

class MenuMainPopup extends StatelessWidget {
  MenuMainPopup({Key? key}) : super(key: key);
  Function()? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: ColorsMain.primary,
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
            onTap: (() {
              onSelected = NavigationFunctions.goToSettings;
            }),
            child: const Text("Settings")),
        PopupMenuItem(
            onTap: (() {
              onSelected = NavigationFunctions.logOut;
            }),
            child: const Text("Log out"))
      ],
      onCanceled: () {
        onSelected?.call();
        onSelected = null;
      },
    );
  }
}
