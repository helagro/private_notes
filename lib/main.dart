import 'package:flutter/material.dart';
import 'package:opnot/screens/editor_screen.dart';
import 'package:opnot/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GlobalKey globalKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Notes',
      //navigatorKey: globalKey,
      //onGenerateRoute: (_) => null,
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => LoginScreen(),
        '/editor': (BuildContext context) => EditorScreen(),
      },
      initialRoute: "/editor",
    );
  }
}
