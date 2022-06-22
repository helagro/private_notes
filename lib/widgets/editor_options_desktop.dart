import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_types/note.dart';
import '../logic/note_handler.dart';
import 'icon_button_main.dart';

class EditorOptionsDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.lime,
      child: Row(
        children: [
          IconButtonMain(
              iconData: CupertinoIcons.trash,
              onPressed: () => deleteNote(context))
        ],
      ),
    );
  }

  void deleteNote(context) {
    NoteHandler.deleteSelectedNote(selectPriorNote: true);
  }
}
