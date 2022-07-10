import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_types/note.dart';
import '../logic/note_handler.dart';
import 'icon_button_main.dart';

class EditorOptionsMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,
      child: Row(
        children: [
          IconButtonMain(
            iconData: Icons.arrow_back,
            onPressed: () => goBackToList(context),
          ),
          const Spacer(),
          IconButtonMain(
            iconData: CupertinoIcons.trash,
            onPressed: () => deleteNote(context),
            tooltip: "Delete note",
          )
        ],
      ),
    );
  }

  void goBackToList(context) {
    Navigator.of(context).popAndPushNamed('editor/note_list');
  }

  void deleteNote(context) {
    NoteHandler.deleteSelectedNote(selectPriorNote: true);
    goBackToList(context);
  }
}
