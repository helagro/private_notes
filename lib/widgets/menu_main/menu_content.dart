import 'package:flutter/material.dart';
import 'package:opnot/logic/navigation_functions.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/menu_main/menu_btn.dart';
import 'package:opnot/widgets/tag_list_item.dart';

class MenuContent extends StatelessWidget {
  MenuContent({Key? key, this.borderColor = ColorsMain.darkBackground})
      : super(key: key);

  final Color borderColor;

  List<String> tags = [
    "house",
    "tanks",
    "sponsor",
    "happens sometimes",
    "watch face",
    "good"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const MenuBtn(
          onPressed: NavigationFunctions.goToSettings, text: "Settings"),
      const MenuBtn(onPressed: NavigationFunctions.logOut, text: "Log out"),
      Container(
        margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 1)),
        padding: const EdgeInsets.all(3),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tags.length,
          itemBuilder: (context, index) {
            return TagListItem(isSelected: index == 1, tagName: tags[index]);
          },
        ),
      )
    ]);
  }
}
