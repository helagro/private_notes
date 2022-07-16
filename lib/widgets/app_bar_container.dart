import 'package:flutter/material.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({Key? key, required this.appBar, required this.content})
      : super(key: key);
  final Widget appBar;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 50, left: 0, right: 0, bottom: 0, child: content),
        Positioned(right: 0, left: 0, top: 0, height: 50, child: appBar)
      ],
    );
  }
}
