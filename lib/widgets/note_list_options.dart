import 'package:flutter/material.dart';
import 'package:private_notes/data_types/note.dart';
import 'package:private_notes/logic/note_handler.dart';
import 'package:private_notes/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';

class NoteListOptions extends StatefulWidget {
  const NoteListOptions({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteListOptionsState();
}

class _NoteListOptionsState extends State<NoteListOptions> {
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
        IconButtonMain(iconData: CupertinoIcons.trash)
      ]),
    );
  }

  void addNote() {
    setState(() {
      NoteHandler.getInstance().notes.add(Note("tx", "cx"));
    });
  }
}
