import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DropboxHandler {
  static DropboxHandler? _instance;
  static const _appKey = "y4hmk1pjerg1vvp";
  String? _token;

  static DropboxHandler getInstance() {
    _instance ??= DropboxHandler();
    return _instance!;
  }

  DropboxHandler() {}

  void generateChallengePair() {}

  void authorize() {
    launchUrl(
        Uri.parse(
            "https://www.dropbox.com/oauth2/authorize?client_id=$_appKey&response_type=code&code_challenge_method=plain&code_challenge=${getCodeChallengeStr()}"),
        webOnlyWindowName: "_blank");
  }

  String getCodeChallengeStr() {
    return "FjbnHORmpnTF08DV45Xab6aUDCahywkSfx6kAe17pKoZXsJ3KP";
  }

  void token(String str) async {
    Map<String, String> headers = {
      "code": str,
      "grant_type": "authorization_code",
      "client_id": _appKey,
      "code_verifier": getCodeChallengeStr()
    };

    print("dwa $headers");
    http.Response res = await http
        .post(Uri.parse("https://api.dropbox.com/oauth2/token"), body: headers);
    print("people ${res.body}");
  }
}
