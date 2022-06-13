import 'package:flutter/material.dart';

class EditorScreen extends StatefulWidget{
  const EditorScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen>{
  @override
  Widget build(BuildContext context) {
    return const Text(
        'You have pushed the button this many times:',
      );
  }

}