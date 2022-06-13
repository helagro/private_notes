import 'package:flutter/material.dart';
import 'package:private_notes/widgets/editor.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
          child: Container(
            color: Colors.blue,
              child: const Text(
          'You have pushed the button this many times:',
              ),
            ),
        ));
  }
}
