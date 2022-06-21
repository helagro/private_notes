import 'package:flutter/material.dart';

import '../../widgets/editor.dart';
import '../../widgets/note_list.dart';
import '../../widgets/note_list_options.dart';

class EditorScreenDesktop extends StatelessWidget {
  const EditorScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Column(children: [NoteListOptions(), NoteList()])),
          EditorWidget()
        ],
      ),
    ));
  }
}
