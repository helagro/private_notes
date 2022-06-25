import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../data_types/note.dart';

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
    //TEMPORARY!
    return "FjbnHORmpnTF08DV45Xab6aUDCahywkSfx6kAe17pKoZXsJ3KP";
  }

  Future<void> token(String str) async {
    Map<String, String> body = {
      "code": str,
      "grant_type": "authorization_code",
      "client_id": _appKey,
      "code_verifier": getCodeChallengeStr()
    };

    http.Response res = await http
        .post(Uri.parse("https://api.dropbox.com/oauth2/token"), body: body);
    Map<String, dynamic> responseBody = jsonDecode(res.body);
    _token = responseBody["access_token"];
    print("moral: ${_token}");
  }

  Future<void> upload(Note note) async {
    Map<String, String> dropboxAPIArg = {"path": "/${note.title}f.txt"};

    Map<String, String> headers = {
      "Authorization": "Bearer $_token",
      "Dropbox-API-Arg": jsonEncode(dropboxAPIArg),
      "Content-Type": "application/octet-stream",
      "Accept": "application/octet-stream"
    };

    print(headers["Authorization"].toString() + "yes");

    http.Response res = await http.post(
        Uri.parse("https://content.dropboxapi.com/2/files/upload"),
        headers: headers,
        body: [100, 100, 100, 100]);
    //Map<String, dynamic> responseBody = jsonDecode(res.body);
    print(res.body + "market");
  }
}
