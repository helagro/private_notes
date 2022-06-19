import 'package:flutter/material.dart';
import 'package:private_notes/data_types/note.dart';
import 'package:private_notes/logic/note_handler.dart';
import 'package:private_notes/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';

class NoteListOptions extends StatelessWidget {
  const NoteListOptions({Key? key, required this.selectedNote})
      : super(key: key);

  final ValueNotifier selectedNote;

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
    NoteHandler.getInstance().addNote(Note("tx", "cx"));
  }

  void deleteNote() {
    NoteHandler.getInstance().removeNote(selectedNote.value);
  }
}
