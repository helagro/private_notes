import 'package:flutter/material.dart';

class IconButtonMain extends StatelessWidget {
  const IconButtonMain({Key? key, required this.iconData, this.onPressed}) : super(key: key);

  final IconData iconData;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(iconData));
  }
}
