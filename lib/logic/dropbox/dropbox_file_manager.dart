import 'dart:convert';

import '../../data_types/note.dart';
import '../note_handler.dart';
import 'package:http/http.dart' as http;

class DropboxFileManager {
  DropboxFileManager(this._token);

  final Future<String?> _token;

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

    if (res.statusCode != 200) throw Exception("Failed to get note list");

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

    if (res.statusCode != 200) return _handleFillNoteContentErrors(res, note);

    note.content = res.body;
    note.isLoaded = true;
  }

  void _handleFillNoteContentErrors(http.Response res, Note note) {
    if (res.headers["content-type"] != "application/json")
      return print("Error in fillNoteContent but no error code");

    final String error = jsonDecode(res.body)["error_summary"];
    final String cleanedError = error.replaceAll(RegExp(r"\/(\.\.\.)$"), "");

    switch (cleanedError) {
      case "path/not_found/":
        NoteHandler.deleteNote(NoteHandler.notes.indexOf(note));
        return;
    }

    note.content = "Loading failed; Error:$cleanedError";
  }

  Future<void> upload(Note note) async {
    if (!note.isLoaded) return;
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

  Future<void> delete(Note note) async {
    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Content-Type": "application/json",
    };

    Map<String, String> body = {"path": "/${note.title}.txt"};

    http.Response res = await http.post(
        Uri.parse("https://api.dropboxapi.com/2/files/delete_v2"),
        headers: headers,
        body: jsonEncode(body));
  }
}
