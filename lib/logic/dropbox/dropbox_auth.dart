import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:opnot/logic/debug.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DropboxAuth {
  static const _appKey = "y4hmk1pjerg1vvp";
  static const _dropboxTokenKey = "dropboxToken";
  static const _dropboxTokenExpireKey = "dropboxExpire";

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _codeVerifier;
  String? _codeChallenge;
  late Future<String?> _token;

  void readToken() async {
    _token = _storage.read(key: _dropboxTokenKey);
    refreshTokenIfNeeded();
  }

  void refreshTokenIfNeeded() async {
    int? tokenExpireTime = await loadTokenExpireTime();
    if (tokenExpireTime == null) return;
    bool tokenHasExpired = tokenExpireTime < DateTime.now().millisecond;
    if (tokenHasExpired) {
      Debug.log("Token has expired, refreshing...");
    }
  }

  Future<int?> loadTokenExpireTime() async {
    String? dropboxTokenExpireTimeStr =
        await _storage.read(key: _dropboxTokenExpireKey);
    if (dropboxTokenExpireTimeStr == null) return null;
    int tokenExpireTime = int.parse(dropboxTokenExpireTimeStr);
    return tokenExpireTime;
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
    String dropboxAuthUrl =
        "https://www.dropbox.com/oauth2/authorize?client_id=$_appKey&response_type=code&code_challenge_method=S256&code_challenge=$_codeChallenge&force_reapprove=false&token_access_type=offline";
    launchUrl(Uri.parse(dropboxAuthUrl),
        webOnlyWindowName: "_blank", mode: LaunchMode.externalApplication);
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

  Future<void> generateToken(String authCode) async {
    Map<String, String> body = {
      "code": authCode,
      "grant_type": "authorization_code",
      "client_id": _appKey,
      "code_verifier": _codeVerifier!
    };

    http.Response res = await http
        .post(Uri.parse("https://api.dropbox.com/oauth2/token"), body: body);

    if (res.statusCode != 200) {
      _handleGenerateTokenErrors(res);
      return;
    }

    Map<String, dynamic> responseBody = jsonDecode(res.body);
    _token = Future.value(responseBody["access_token"]);

    _storage.write(key: _dropboxTokenKey, value: await _token);
    _storage.write(
        key: _dropboxTokenExpireKey, value: getTokenExpireTime(responseBody));
  }

  void _handleGenerateTokenErrors(final http.Response res) {
    if (res.headers["content-type"] != "application/json") {
      throw Exception("Invalid content-type for token");
    }
  }

  String getTokenExpireTime(Map<String, dynamic> responseBody) {
    DateTime timeNow = DateTime.now();
    print(responseBody["expires_in"]);
    int expiresInMillis = int.parse(responseBody["expires_in"]) * 1000;
    Duration expiresInDuration = Duration(milliseconds: expiresInMillis);
    DateTime tokenExpireTime = timeNow.add(expiresInDuration);
    return tokenExpireTime.millisecond.toString();
  }
}
