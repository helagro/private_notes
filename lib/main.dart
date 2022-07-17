import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/screens/editor_screen.dart';
import 'package:opnot/screens/login_screen.dart';
import 'package:opnot/screens/settings_screen.dart';

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
            primary: ColorsMain.primary,
            background: ColorsMain.background,
            primaryContainer: ColorsMain.primaryContainer,
            secondaryContainer: ColorsMain.secondaryContainer,
            tertiaryContainer: ColorsMain.tertiaryContainer,
          ),
          textTheme:
              const TextTheme(headline1: TextStyle(fontSize: 30, height: 40))),

      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => LoginScreen(),
        '/editor': (BuildContext context) => EditorScreen(),
        '/settings': (BuildContext context) => const SettingsScreen(),
      },
      initialRoute: "/editor",
    );
  }
}
