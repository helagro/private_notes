import 'package:flutter/material.dart';

import '../data_types/note.dart';
import '../logic/note_handler.dart';

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
        padding: const EdgeInsets.all(5),
        color: Colors.blue,
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Center(
                child: Text(
              NoteHandler.getInstance().notes[i].title,
              style: const TextStyle(fontSize: 24),
            ));
          },
          itemCount: NoteHandler.getInstance().notes.length,
        ),
      ),
    ));
  }
}
