import 'package:flutter/material.dart';
import 'package:private_notes/widgets/editor.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [Text("DWA"), EditorWidget()],
      ),
    );
  }
}
