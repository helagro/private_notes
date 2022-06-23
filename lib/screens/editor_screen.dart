import 'package:flutter/material.dart';
import 'desktop/editor_screen_desktop.dart';
import 'mobile/editor_and_list_mobile.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 750) {
        return const EditorScreenDesktop();
      }
      return const EditorAndListMobile();
    }));
  }
}
