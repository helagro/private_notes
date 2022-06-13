import 'package:flutter/material.dart';
import 'package:private_notes/widgets/editor.dart';
import 'package:private_notes/widgets/note_list.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: const NoteList()),
          const EditorWidget()
        ],
      ),
    ));
  }
}
