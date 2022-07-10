import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opnot/widgets/app_bar_main.dart';
import '../logic/note_handler.dart';
import 'icon_button_main.dart';

class EditorOptionsDesktop extends StatelessWidget {
  const EditorOptionsDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarMain(
      children: [
        IconButtonMain(
          iconData: CupertinoIcons.trash,
          onPressed: () => deleteNote(context),
          tooltip: "Delete note",
        )
      ],
    );
  }

  void deleteNote(context) {
    NoteHandler.deleteSelectedNote(selectPriorNote: true);
  }
}
