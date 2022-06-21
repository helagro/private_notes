import 'package:flutter/material.dart';

import 'note_list.dart';

class EditorAndListMobile extends StatelessWidget {
  const EditorAndListMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: "note_list",
        onGenerateRoute: ((RouteSettings settings) {
          WidgetBuilder builder;

          switch (settings.name) {
            case "note_list":
              builder = (BuildContext _) => NoteListScreenMobile();
              break;
            case "editor":
              builder = (BuildContext _) => NoteListScreenMobile();
              break;
            default:
              throw Exception("Invalid route");
          }

          return MaterialPageRoute<void>(builder: builder, settings: settings);
        }));
  }
}
