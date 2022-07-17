import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:opnot/data_types/note.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/logic/note_handler.dart';
import 'package:opnot/main.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/res/dimensions.dart';
import 'package:opnot/widgets/app_bars/app_bar_main.dart';
import 'package:opnot/widgets/icon_button_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:opnot/widgets/menu_main/menu_drawer_btn.dart';

class NoteListOptions extends StatelessWidget {
  final Function? onNoteAddedListener;

  const NoteListOptions({Key? key, this.onNoteAddedListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarMain(children: [
      Expanded(
        child: LayoutBuilder(builder: ((context, constraints) {
          final bool showTagList = Dimensions.showTagList(context);

          return Row(
            textDirection: showTagList ? TextDirection.ltr : TextDirection.rtl,
            children: [
              showTagList ? MenuDrawerBtn() : Container(),
              const Spacer(),
              IconButtonMain(
                iconData: CupertinoIcons.pencil,
                onPressed: addNote,
                tooltip: "Add note",
              ),
            ],
          );
        })),
      ),
    ]);
  }

  void addNote() {
    NoteHandler.addNote(
        Note("tx(${DateTime.now().second})", "cx(${DateTime.now().second})",
            isLoaded: true),
        selectNote: true);
    onNoteAddedListener?.call();
  }
}
