import 'package:flutter/material.dart';
import 'package:private_notes/screens/mobile/note_list.dart';
import 'package:private_notes/widgets/editor.dart';
import 'package:private_notes/widgets/note_list.dart';
import 'package:private_notes/widgets/note_list_options.dart';

import 'desktop/editor.dart';
import 'mobile/editor_and_list.dart';

class EditorScreen extends StatelessWidget {
  EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 600) {
        return EditorScreenDesktop();
      }
      return EditorAndListMobile();
    }));
  }
}
