import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../data_types/note.dart';

class DropboxHandler {
  static DropboxHandler? _instance;
  static const _appKey = "y4hmk1pjerg1vvp";
  String? _token;
  String? _codeVerifier;
  String? _codeChallenge;

  static DropboxHandler getInstance() {
    _instance ??= DropboxHandler();
    return _instance!;
  }

  DropboxHandler() {
    print("yeah nah yeah nah yeah nah");
    generateCodeChallengePair();
  }

  void generateChallengePair() {}

  void authorize() {
    launchUrl(
        Uri.parse(
            "https://www.dropbox.com/oauth2/authorize?client_id=$_appKey&response_type=code&code_challenge_method=S256&code_challenge=$_codeChallenge"),
        webOnlyWindowName: "_blank");
  }

  void generateCodeChallengePair() {
    const characters =
        "abcdefghijklmnopqrstuvwxyzACBDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final random = Random.secure();
    final codeVerifierBuffer = StringBuffer();

    for (int i = 0; i < 128; i++) {
      int randomCharactersIndex = random.nextInt(characters.length);
      codeVerifierBuffer.write(characters[randomCharactersIndex]);
    }
    _codeVerifier = codeVerifierBuffer.toString();
    final byteCodeChallenge = sha256.convert(utf8.encode(_codeVerifier!)).bytes;
    final base64CodeChallenge =
        const Base64Encoder.urlSafe().convert(byteCodeChallenge);
    _codeChallenge = base64CodeChallenge.replaceAll("=", "").toString();
    print("verifier:?$_codeVerifier?\nchallenges:?$_codeChallenge?");
  }

  Future<void> token(String str) async {
    Map<String, String> body = {
      "code": str,
      "grant_type": "authorization_code",
      "client_id": _appKey,
      "code_verifier": _codeVerifier!
    };

    http.Response res = await http
        .post(Uri.parse("https://api.dropbox.com/oauth2/token"), body: body);
    Map<String, dynamic> responseBody = jsonDecode(res.body);
    _token = responseBody["access_token"];
  }

  Future<List<Note>> list() async {
    print("7 cents" + _token.toString());
    Map<String, String> headers = {
      "Authorization": "Bearer $_token",
      "Content-Type": "application/json",
    };

    Map<String, dynamic> body = {
      "include_deleted": false,
      "include_has_explicit_shared_members": false,
      "include_media_info": false,
      "include_mounted_folders": true,
      "include_non_downloadable_files": false,
      "path": "",
      "recursive": false
    };

    http.Response res = await http.post(
        Uri.parse("https://api.dropboxapi.com/2/files/list_folder"),
        headers: headers,
        body: jsonEncode(body));
    //Map<String, dynamic> responseBody = jsonDecode(res.body);

    print("heafefa ${res.body}, $res");
    return [];
  }

  Future<void> upload(Note note) async {
    Map<String, String> dropboxAPIArg = {
      "path": "/${note.title}.txt",
      "mode": "overwrite"
    };

    Map<String, String> headers = {
      "Authorization": "Bearer $_token",
      "Dropbox-API-Arg": jsonEncode(dropboxAPIArg),
      "Content-Type": "application/octet-stream",
      "Accept": "application/octet-stream"
    };

    http.Response res = await http.post(
        Uri.parse("https://content.dropboxapi.com/2/files/upload"),
        headers: headers,
        body: utf8.encode(note.content));
    //Map<String, dynamic> responseBody = jsonDecode(res.body);
    print(res.body + "market");
  }
}
