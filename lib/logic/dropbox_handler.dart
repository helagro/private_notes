import 'package:url_launcher/url_launcher.dart';

class DropboxHandler {
  void authorize() {
    launchUrl(Uri(path: "https://flutter.dev"), webOnlyWindowName: "_blank");
  }
}
