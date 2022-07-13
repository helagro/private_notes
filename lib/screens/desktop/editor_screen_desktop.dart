import 'package:flutter/material.dart';
import 'package:opnot/widgets/editor_options_desktop.dart';

import '../../widgets/editor.dart';
import '../../widgets/editor_options_mobile.dart';
import '../../widgets/note_list/note_list.dart';
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
              constraints: const BoxConstraints(maxWidth: 320),
              child: Column(children: [NoteListOptions(), const NoteList()])),
          Container(
            width: 1,
            color: Theme.of(context).colorScheme.background,
          ),
          Expanded(
              child: Column(
                  children: const [EditorOptionsDesktop(), EditorWidget()]))
        ],
      ),
    ));
  }
}
