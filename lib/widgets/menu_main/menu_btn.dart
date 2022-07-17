import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({Key? key, required this.onPressed, required this.text})
      : super(key: key);
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 4),
      child: Card(
        color: ColorsMain.primaryContainer,
        margin: const EdgeInsets.all(0),
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}
