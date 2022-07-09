import 'package:flutter/material.dart';
import 'package:opnot/screens/editor_screen.dart';
import 'package:opnot/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Notes',
      navigatorKey: navigatorKey,
      //onGenerateRoute: (_) => null,
      theme: ThemeData(
          // This is the theme of your application.
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFFF09515),
              background: const Color(0xffffffff),
              primaryContainer: const Color(0xFFFdfdfd))),
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => LoginScreen(),
        '/editor': (BuildContext context) => EditorScreen(),
      },
      initialRoute: "/editor",
    );
  }
}
