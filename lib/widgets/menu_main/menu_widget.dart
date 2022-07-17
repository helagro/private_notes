import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/menu_main/menu_content.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorsMain.darkBackground,
        padding: const EdgeInsets.only(top: 20),
        child: MenuContent(
          borderColor: ColorsMain.detailColor,
        ));
  }
}
