import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/main.dart';

class NavigationFunctions {
  static void goToSettings() {
    MyApp.navigatorKey.currentState?.pushNamed("/settings");
  }

  static void logOut() {
    DropboxHandler.getAuth().logOut();
    MyApp.navigatorKey.currentState?.pushNamed("/login");
  }
}
