import 'package:url_launcher/url_launcher.dart';

class DropboxHandler {
  void authorize() {
    launchUrl(
        Uri.parse(
            "https://www.dropbox.com/oauth2/authorize?client_id=y4hmk1pjerg1vvp&response_type=code"),
        webOnlyWindowName: "_blank");
  }
}
