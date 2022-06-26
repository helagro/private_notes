import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../data_types/note.dart';
import 'note_handler.dart';

class DropboxHandler {
  static DropboxHandler? _instance;
  static const _appKey = "y4hmk1pjerg1vvp";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _dropboxTokenKey = "dropboxToken";
  String? _codeVerifier;
  String? _codeChallenge;
  Future<String?>? _token;

  static DropboxHandler getInstance() {
    _instance ??= DropboxHandler();
    return _instance!;
  }

  DropboxHandler() {
    _readToken();
  }

  void _readToken() async {
    _token = _storage.read(key: _dropboxTokenKey);
  }

  Future<bool> hasToken() async {
    String? tokenValue = await _token;
    return tokenValue != null;
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
    Map<String, dynamic> responseBody = jsonDecode(res.body);
    _token = Future.value(responseBody["access_token"]);
    _storage.write(key: _dropboxTokenKey, value: await _token);
    //print("troy :${await _token}");
  }

  Future<List<Note>> getNotes() async {
    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Content-Type": "application/json",
    };

    const Map<String, dynamic> body = {
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
    Map<String, dynamic> responseBody = jsonDecode(res.body);

    return await _getNotesFromHttpResponseBody(responseBody);
  }

  Future<List<Note>> _getNotesFromHttpResponseBody(
      Map<String, dynamic> responseBody) async {
    List<Note> notes = List<Note>.empty(growable: true);
    for (final entry in responseBody["entries"]) {
      String fileName = entry["name"];
      Note note =
          Note(fileName.replaceAll(RegExp(r'\.*(.txt)'), ""), "Loading...");
      notes.add(note);
    }
    return notes;
  }

  Future<void> fillNoteContent(Note note) async {
    Map<String, String> dropboxAPIArg = {
      "path": "/${note.title}.txt",
    };

    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Dropbox-API-Arg": jsonEncode(dropboxAPIArg)
    };

    http.Response res = await http.post(
        Uri.parse("https://content.dropboxapi.com/2/files/download"),
        headers: headers);
    note.content = res.body;
  }

  Future<void> upload(Note note) async {
    Map<String, String> dropboxAPIArg = {
      "path": "/${note.title}.txt",
      "mode": "overwrite"
    };

    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Dropbox-API-Arg": jsonEncode(dropboxAPIArg),
      "Content-Type": "application/octet-stream",
      "Accept": "application/octet-stream"
    };

    http.Response res = await http.post(
        Uri.parse("https://content.dropboxapi.com/2/files/upload"),
        headers: headers,
        body: utf8.encode(note.content));
    //Map<String, dynamic> responseBody = jsonDecode(res.body);
  }
}
