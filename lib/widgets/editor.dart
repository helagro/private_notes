import 'package:flutter/material.dart';

class EditorWidget extends StatefulWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
          child: Container(
            color: Colors.red,
              child: const Text(
          'You have pushed the button this many times:',
              ),
            ),
        ));
  }
}
