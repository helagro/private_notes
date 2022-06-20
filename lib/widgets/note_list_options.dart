import 'package:flutter/material.dart';
import 'package:private_notes/data_types/note.dart';
import 'package:private_notes/logic/note_handler.dart';
import 'package:private_notes/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';

class NoteListOptions extends StatelessWidget {
  NoteListOptions({Key? key, required this.selectedNote}) : super(key: key);

  final ValueNotifier selectedNote;
  final NoteHandler _noteHandler = NoteHandler.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      color: Colors.green,
      child: Row(children: [
        IconButtonMain(
          iconData: CupertinoIcons.create,
          onPressed: addNote,
        ),
        const Spacer(),
        IconButtonMain(iconData: CupertinoIcons.trash, onPressed: deleteNote)
      ]),
    );
  }

  void addNote() {
    _noteHandler.addNote(
        Note("tx(${DateTime.now().second})", "cx(${DateTime.now().second})"));
    selectedNote.value = _noteHandler.notes.length - 1;
  }

  void deleteNote() {
    final noteAmtBeforeDelete = _noteHandler.notes.length;
    if (noteAmtBeforeDelete == 0) return;

    _noteHandler.removeNote(selectedNote.value);
    if (noteAmtBeforeDelete != 1) {
      selectedNote.value -= 1;
    }
  }
}
