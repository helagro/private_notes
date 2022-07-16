import 'package:flutter/material.dart';
import 'package:opnot/widgets/app_bar_container.dart';

import '../../widgets/note_list/note_list.dart';
import '../../widgets/note_list_options.dart';

class NoteListScreenMobile extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;

  const NoteListScreenMobile({Key? key, required this.navKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AppBarContainer(
      content: NoteList(
        onNoteSelected: () => goToEditor(context),
        highlightSelectedNote: false,
      ),
      appBar: NoteListOptions(onNoteAddedListener: () => goToEditor(context)),
    )));
  }

  void goToEditor(context) {
    navKey.currentState?.pushNamed('editor/editor');
  }
}
