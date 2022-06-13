import 'package:flutter/material.dart';

class IconButtonMain extends StatelessWidget {
  const IconButtonMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.note_add));
  }
}
