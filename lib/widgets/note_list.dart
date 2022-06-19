import 'package:flutter/material.dart';
import '../logic/note_handler.dart';
import 'note_list_item.dart';

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
      child: Container(
        color: Colors.blue,
        child: ListView.builder(
          itemBuilder: (context, noteListIndex) {
            return NoteListItem(
              onClick: onNoteListItemClicked,
              noteListIndex: noteListIndex,
              isSelected: noteListIndex == widget.selectedNote.value,
            );
          },
          itemCount: NoteHandler.getInstance().notes.length,
        ),
      ),
    ));
  }

  void onNoteListItemClicked(int noteListIndex) {
    setState(() {
      widget.selectedNote.value = noteListIndex;
    });
  }
}
