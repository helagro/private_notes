import 'package:flutter/material.dart';
import '../logic/note_handler.dart';

class NoteList extends StatefulWidget {
  final ValueNotifier selectedNote;

  const NoteList({Key? key, required this.selectedNote}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final NoteHandler _noteHandler = NoteHandler.getInstance();

  _NoteListState() {
    _noteHandler.addNoteListChangedListener(reloadNoteList);
  }

  void reloadNoteList() {
    print("plate");
    setState(() {});
  }

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
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 24)),
                onPressed: () {
                  widget.selectedNote.value = i;
                },
                child: Text(
                  NoteHandler.getInstance().notes[i].title,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          },
          itemCount: NoteHandler.getInstance().notes.length,
        ),
      ),
    ));
  }
}
