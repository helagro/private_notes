import 'package:flutter/material.dart';
import 'package:opnot/data_types/note.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/logic/note_handler.dart';
import 'package:opnot/main.dart';
import 'package:opnot/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';

class NoteListOptions extends StatelessWidget {
  final Function? onNoteAddedListener;

  const NoteListOptions({Key? key, this.onNoteAddedListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.green,
      child: Row(children: [
        PopupMenuButton(
          icon: const Icon(Icons.person_outline_rounded),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
                onTap: (() => logOut(context)), child: const Text("Log out"))
          ],
        ),
        const Spacer(),
        IconButtonMain(
          iconData: CupertinoIcons.pencil,
          onPressed: addNote,
          tooltip: "Add note",
        ),
      ]),
    );
  }

  void logOut(BuildContext context) {
    DropboxHandler.getAuth().logOut();
    MyApp.navigatorKey.currentState?.popAndPushNamed("/login");
  }

  void addNote() {
    NoteHandler.addNote(
        Note("tx(${DateTime.now().second})", "cx(${DateTime.now().second})",
            isLoaded: true),
        selectNote: true);
    onNoteAddedListener?.call();
  }
}
