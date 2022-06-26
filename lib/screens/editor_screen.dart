import 'package:flutter/material.dart';
import 'package:private_notes/logic/dropbox_handler.dart';
import 'package:private_notes/logic/note_handler.dart';
import 'desktop/editor_screen_desktop.dart';
import 'mobile/editor_and_list_mobile.dart';

class EditorScreen extends StatelessWidget {
  EditorScreen({Key? key}) : super(key: key) {}

  void loadNotes() async {
    NoteHandler.notes.addAll(await DropboxHandler.getInstance().list());
    NoteHandler.callNoteListChangedListeners();
  }

  @override
  Widget build(BuildContext context) {
    DropboxHandler.getInstance();
    //loadNotes();
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 750) {
        return const EditorScreenDesktop();
      }
      return EditorAndListMobile();
    }));
  }
}
