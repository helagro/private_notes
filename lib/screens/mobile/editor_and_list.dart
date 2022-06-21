import 'package:flutter/material.dart';
import 'package:private_notes/screens/mobile/editor.dart';

import 'note_list.dart';

class EditorAndListMobile extends StatelessWidget {
  const EditorAndListMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: "editor/note_list",
        onGenerateRoute: ((RouteSettings settings) {
          WidgetBuilder builder;

          switch (settings.name) {
            case "editor/note_list":
              builder = (BuildContext _) => const NoteListScreenMobile();
              break;
            case "editor/editor":
              builder = (BuildContext _) => const EditorScreenMobile();
              break;
            default:
              throw Exception("Invalid route");
          }

          return MaterialPageRoute<void>(builder: builder, settings: settings);
        }));
  }
}
