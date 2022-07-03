import 'package:flutter/material.dart';
import 'package:opnot/screens/mobile/editor_screen_mobile.dart';

import 'note_list_screen_mobile.dart';

class EditorAndListMobile extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool isOnNoteList = true;

  EditorAndListMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Navigator(
            initialRoute: "editor/note_list",
            key: _navigatorKey,
            onGenerateRoute: ((RouteSettings settings) {
              WidgetBuilder builder;

              switch (settings.name) {
                case "editor/note_list":
                  isOnNoteList = true;
                  builder = (BuildContext _) => NoteListScreenMobile(
                        navKey: _navigatorKey,
                      );
                  break;
                case "editor/editor":
                  isOnNoteList = false;
                  builder = (BuildContext _) => const EditorScreenMobile();
                  break;
                default:
                  throw Exception("Invalid route");
              }

              return MaterialPageRoute<void>(
                  builder: builder, settings: settings);
            })),
        onWillPop: () async {
          print("is $isOnNoteList ${_navigatorKey.currentState}");
          _navigatorKey.currentState?.maybePop();
          return isOnNoteList;
        });
  }
}
