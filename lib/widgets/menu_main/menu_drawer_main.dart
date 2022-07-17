import 'package:flutter/material.dart';
import 'package:opnot/logic/navigation_functions.dart';
import 'package:opnot/main.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/icon_button_main.dart';
import 'package:opnot/widgets/menu_main/menu_content.dart';
import 'package:opnot/widgets/tag_list_item.dart';

class MenuDrawerMain extends StatelessWidget {
  MenuDrawerMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("built");
    return Drawer(
      width: 200,
      child: Container(
        margin: const EdgeInsets.only(top: 3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButtonMain(
                  iconData: Icons.close,
                  onPressed: () {
                    Scaffold.of(context).closeDrawer();
                  },
                ),
              ],
            ),
            Expanded(child: MenuContent())
          ],
        ),
      ),
    );
  }
}
