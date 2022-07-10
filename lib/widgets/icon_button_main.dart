import 'package:flutter/material.dart';
import 'package:opnot/main.dart';

class IconButtonMain extends StatelessWidget {
  const IconButtonMain(
      {Key? key, required this.iconData, this.onPressed, this.tooltip})
      : super(key: key);

  final IconData iconData;
  final void Function()? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: Theme.of(context).colorScheme.primary,
        ),
        tooltip: tooltip);
  }
}
