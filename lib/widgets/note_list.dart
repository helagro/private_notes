import 'package:flutter/material.dart';
import '../logic/note_handler.dart';
import 'note_list_item.dart';

class NoteList extends StatefulWidget {
  final Function? onNoteSelected;
  final bool highlightSelectedNote;

  const NoteList(
      {Key? key, this.onNoteSelected, this.highlightSelectedNote = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  _NoteListState() {
    NoteHandler.addNoteListChangedListener(reloadNoteList);
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
              isSelected: noteListIndex == NoteHandler.selectedNote.value &&
                  widget.highlightSelectedNote,
            );
          },
          itemCount: NoteHandler.notes.length,
        ),
      ),
    ));
  }

  void onNoteListItemClicked(int noteListIndex) {
    setState(() {
      NoteHandler.selectedNote.value = noteListIndex;
    });
    widget.onNoteSelected?.call();
  }
}
