import 'package:flutter/material.dart';
import 'package:private_notes/screens/editor_screen.dart';
import 'package:private_notes/screens/login_screen.dart';

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
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => LoginScreen(),
        '/editor': (BuildContext context) => EditorScreen(),
      },
      initialRoute: "/login",
    );
  }
}
