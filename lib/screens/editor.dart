import 'package:flutter/material.dart';
import 'package:private_notes/screens/mobile/note_list.dart';
import 'package:private_notes/widgets/editor.dart';
import 'package:private_notes/widgets/note_list.dart';
import 'package:private_notes/widgets/note_list_options.dart';

import 'desktop/editor.dart';

class EditorScreen extends StatelessWidget {
  EditorScreen({Key? key}) : super(key: key);
  final ValueNotifier selectedNote = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 600) {
        return EditorScreenDesktop(selectedNote: selectedNote);
      }
      return NoteListScreenMobile(selectedNote: selectedNote);
    }));
  }
}
