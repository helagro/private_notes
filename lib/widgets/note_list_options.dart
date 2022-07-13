import 'dart:developer';

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
  Function()? onSelected;

  NoteListOptions({Key? key, this.onNoteAddedListener}) : super(key: key);

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
                onSelected = goToSettings;
              }),
              child: const Text("Settings")),
          PopupMenuItem(
              onTap: (() {
                onSelected = () => logOut(context);
              }),
              child: const Text("Log out"))
        ],
        onCanceled: () {
          onSelected?.call();
          onSelected = null;
        },
      ),
      const Spacer(),
      IconButtonMain(
        iconData: CupertinoIcons.pencil,
        onPressed: addNote,
        tooltip: "Add note",
      ),
    ]);
  }

  void goToSettings() {
    MyApp.navigatorKey.currentState?.pushNamed("/settings");
  }

  void logOut(BuildContext context) {
    DropboxHandler.getAuth().logOut();
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
