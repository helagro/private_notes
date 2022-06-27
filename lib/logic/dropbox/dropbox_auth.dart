import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DropboxAuth {
  static const _appKey = "y4hmk1pjerg1vvp";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _dropboxTokenKey = "dropboxToken";
  String? _codeVerifier;
  String? _codeChallenge;
  late Future<String?> _token;

  void readToken() async {
    _token = _storage.read(key: _dropboxTokenKey);
  }

  Future<bool> hasToken() async {
    String? tokenValue = await _token;
    return tokenValue != null;
  }

  Future<String?> getToken() {
    return _token;
  }

  void authorize() {
    _generateCodeChallengePair();
    launchUrl(
        Uri.parse(
            "https://www.dropbox.com/oauth2/authorize?client_id=$_appKey&response_type=code&code_challenge_method=S256&code_challenge=$_codeChallenge"),
        webOnlyWindowName: "_blank",
        mode: LaunchMode.externalApplication);
  }

  void _generateCodeChallengePair() {
    _codeVerifier = _createCodeVerifier();
    final byteCodeChallenge = sha256.convert(utf8.encode(_codeVerifier!)).bytes;
    final base64CodeChallenge =
        const Base64Encoder.urlSafe().convert(byteCodeChallenge);
    _codeChallenge = base64CodeChallenge.replaceAll("=", "").toString();
  }

  String _createCodeVerifier() {
    const characters =
        "abcdefghijklmnopqrstuvwxyzACBDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final random = Random.secure();
    final codeVerifierBuffer = StringBuffer();

    for (int i = 0; i < 128; i++) {
      int randomCharactersIndex = random.nextInt(characters.length);
      codeVerifierBuffer.write(characters[randomCharactersIndex]);
    }
    return codeVerifierBuffer.toString();
  }

  Future<void> generateToken(String str) async {
    Map<String, String> body = {
      "code": str,
      "grant_type": "authorization_code",
      "client_id": _appKey,
      "code_verifier": _codeVerifier!
    };

    http.Response res = await http
        .post(Uri.parse("https://api.dropbox.com/oauth2/token"), body: body);

    if (res.statusCode != 200) return _handleGenerateTokenErrors(res);

    Map<String, dynamic> responseBody = jsonDecode(res.body);
    _token = Future.value(responseBody["access_token"]);
    _storage.write(key: _dropboxTokenKey, value: await _token);
  }

  void _handleGenerateTokenErrors(final http.Response res) {
    if (res.headers["content-type"] != "application/json") throw Exception();
  }
}
