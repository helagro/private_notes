import 'package:flutter/material.dart';
import 'package:private_notes/logic/dropbox_handler.dart';
import 'package:private_notes/logic/note_handler.dart';
import 'desktop/editor_screen_desktop.dart';
import 'mobile/editor_and_list_mobile.dart';

class EditorScreen extends StatelessWidget {
  EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleDropbox(context);
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 750) {
        return const EditorScreenDesktop();
      }
      return EditorAndListMobile();
    }));
  }

  void handleDropbox(final BuildContext context) {
    DropboxHandler dropboxHandler = DropboxHandler.getInstance();
    dropboxHandler.hasToken().then((hasToken) {
      if (hasToken) {
        NoteHandler.loadNoteList();
      } else {
        Navigator.pushNamed(context, "/login");
      }
    });
  }
}
