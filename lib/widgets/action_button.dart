import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, this.onPressed, required this.title})
      : super(key: key);

  final Function? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed?.call(),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorsMain.secondaryContainer)),
      child: Text(title, style: const TextStyle(fontSize: 16)),
    );
  }
}
