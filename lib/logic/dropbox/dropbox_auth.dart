import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:opnot/logic/debug.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DropboxAuth {
  static const _appKey = "y4hmk1pjerg1vvp";
  static const _dropboxRefreshTokenKey = "dropboxRefreshToken";

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late String _codeVerifier;
  late String _codeChallenge;
  late Future<String?> _token = Future(readToken);

  Future<String?> readToken() async {
    String? refreshToken = await _storage.read(key: _dropboxRefreshTokenKey);
    if (refreshToken == null) {
      Debug.log("Could not find a stored refresh token");
      return null;
    }

    Debug.log("Found a stored refresh token");
    return await _requestToken(refreshToken: refreshToken);
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
    final byteCodeChallenge = sha256.convert(utf8.encode(_codeVerifier)).bytes;
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

  Future<void> aquireToken(String authCode) async {
    _token = _requestToken(authCode: authCode);
    await _token;
  }

  Future<String?> _requestToken(
      {String? authCode, String? refreshToken}) async {
    assert((authCode != null) ^ (refreshToken != null));

    bool isReAuth = refreshToken != null;

    Map<String, String> body = {
      "grant_type": isReAuth ? "refresh_token" : "authorization_code",
      "client_id": _appKey,
    };

    if (isReAuth) {
      body.addAll({"refresh_token": refreshToken});
    } else {
      body.addAll({
        "code": authCode!,
        "code_verifier": _codeVerifier,
      });
    }

    http.Response res = await http
        .post(Uri.parse("https://api.dropbox.com/oauth2/token"), body: body);

    Map<String, dynamic> responseBody = jsonDecode(res.body);
    if (!isReAuth) {
      String? newRefreshToken = responseBody["refresh_token"];
      _storage.write(key: _dropboxRefreshTokenKey, value: newRefreshToken);
    }

    Debug.log("Received access token");
    return responseBody["access_token"];
  }

  void logOut() {
    _storage.delete(key: _dropboxRefreshTokenKey);
    _token = Future.value(null);
  }
}
