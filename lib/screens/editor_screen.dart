import 'package:flutter/material.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/logic/note_handler.dart';
import 'package:opnot/widgets/menu_main/menu_drawer_main.dart';
import 'desktop/editor_screen_desktop.dart';
import 'mobile/editor_and_list_mobile.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleDropbox(context);
    return Scaffold(
      drawer: MenuDrawerMain(),
      body: LayoutBuilder(builder: ((context, constraints) {
        if (constraints.maxWidth > 750) {
          return const EditorScreenDesktop();
        }
        return EditorAndListMobile();
      })),
    );
  }

  void handleDropbox(final BuildContext context) {
    DropboxHandler.getAuth().hasToken().then((hasToken) {
      if (hasToken) {
        DropboxHandler.getFileManager()
            .init(DropboxHandler.getAuth().getToken());
        NoteHandler.loadNoteList(context);
      } else {
        Navigator.pushNamed(context, "/login");
      }
    });
  }
}
