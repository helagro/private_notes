import 'package:flutter/material.dart';
import 'package:opnot/data_types/note.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/logic/note_handler.dart';
import 'package:opnot/main.dart';
import 'package:opnot/widgets/app_bar_main.dart';
import 'package:opnot/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';

class NoteListOptions extends StatelessWidget {
  final Function? onNoteAddedListener;

  const NoteListOptions({Key? key, this.onNoteAddedListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarMain(children: [
      PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.primary,
        ),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
              onTap: (() {
                Navigator.of(context).pop();
                var route =
                    MyApp.navigatorKey.currentState?.pushNamed("/settings");
                route?.then((value) {
                  print("  $value  val");
                });
              }),
              child: const Text("Settings")),
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
    ]);
  }

  void logOut(BuildContext context) {
    DropboxHandler.getAuth().logOut();
    Navigator.of(context).pop();
    MyApp.navigatorKey.currentState?.pushNamed("/login");
  }

  void addNote() {
    NoteHandler.addNote(
        Note("tx(${DateTime.now().second})", "cx(${DateTime.now().second})",
            isLoaded: true),
        selectNote: true);
    onNoteAddedListener?.call();
  }
}
