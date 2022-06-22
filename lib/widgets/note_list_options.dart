import 'package:flutter/material.dart';
import 'package:private_notes/data_types/note.dart';
import 'package:private_notes/logic/note_handler.dart';
import 'package:private_notes/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';

class NoteListOptions extends StatelessWidget {
  final Function? onNoteAddedListener;

  NoteListOptions({Key? key, this.onNoteAddedListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.green,
      child: Row(children: [
        IconButtonMain(
          iconData: CupertinoIcons.create,
          onPressed: addNote,
        ),
        const Spacer(),
      ]),
    );
  }

  void addNote() {
    NoteHandler.addNote(
        Note("tx(${DateTime.now().second})", "cx(${DateTime.now().second})"),
        selectNote: true);
    onNoteAddedListener?.call();
  }
}
