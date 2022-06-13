import 'package:flutter/material.dart';

import '../data_types/note.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<Note> notes = List.from([Note("t1", "c1"), Note("t2", "c2")]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
      child: Container(
        color: Colors.blue,
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Text(notes[i].title);
          },
          itemCount: notes.length,
        ),
      ),
    ));
  }
}
