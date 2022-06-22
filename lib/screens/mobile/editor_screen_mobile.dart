import 'package:flutter/material.dart';
import 'package:private_notes/screens/mobile/editor_options_mobile.dart';
import 'package:private_notes/widgets/icon_button_main.dart';

import '../../widgets/editor.dart';
import '../../widgets/note_list.dart';
import '../../widgets/note_list_options.dart';

class EditorScreenMobile extends StatelessWidget {
  const EditorScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [EditorOptionsMobile(), EditorWidget()]),
    ));
  }
}
