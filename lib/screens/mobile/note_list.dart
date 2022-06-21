import 'package:flutter/material.dart';

import '../../widgets/editor.dart';
import '../../widgets/note_list.dart';
import '../../widgets/note_list_options.dart';

class NoteListScreenMobile extends StatelessWidget {
  const NoteListScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            SafeArea(child: Column(children: [NoteListOptions(), NoteList()])));
  }
}
