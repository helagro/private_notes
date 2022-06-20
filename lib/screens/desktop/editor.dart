import 'package:flutter/material.dart';

import '../../widgets/editor.dart';
import '../../widgets/note_list.dart';
import '../../widgets/note_list_options.dart';

class EditorScreenDesktop extends StatelessWidget {
  final ValueNotifier selectedNote;
  const EditorScreenDesktop({Key? key, required this.selectedNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Column(children: [
                NoteListOptions(selectedNote: selectedNote),
                NoteList(selectedNote: selectedNote)
              ])),
          EditorWidget(selectedNote: selectedNote)
        ],
      ),
    ));
  }
}
