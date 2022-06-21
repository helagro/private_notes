import 'package:flutter/material.dart';
import 'package:private_notes/data_types/note.dart';
import 'package:private_notes/logic/note_handler.dart';
import 'package:private_notes/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';

class NoteListOptions extends StatelessWidget {
  NoteListOptions({Key? key}) : super(key: key);

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
    NoteHandler.addNote(
        Note("tx(${DateTime.now().second})", "cx(${DateTime.now().second})"),
        selectNote: true);
  }

  void deleteNote() {
    NoteHandler.deleteSelectedNote(selectPriorNote: true);
  }
}
