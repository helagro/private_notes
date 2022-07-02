import 'dart:convert';

import 'package:opnot/logic/debug.dart';
import 'package:opnot/logic/dropbox/dropbox_helpers.dart';

import '../../data_types/note.dart';
import '../note_handler.dart';
import 'package:http/http.dart' as http;

class DropboxFileManager {
  DropboxFileManager(this._token);
  final Future<String?> _token;
  static const _mainUrl = "https://api.dropboxapi.com/2/files";

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

    http.Response res = await http.post(Uri.parse("$_mainUrl/list_folder"),
        headers: headers, body: jsonEncode(body));

    if (res.statusCode != 200) throw Exception("Failed to get note list");

    Map<String, dynamic> responseBody = jsonDecode(res.body);
    Debug.log("Loaded note list");

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
      "path": DropboxHelpers.getNoteFilePath(note),
    };

    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Dropbox-API-Arg": jsonEncode(dropboxAPIArg)
    };

    http.Response res =
        await http.post(Uri.parse("$_mainUrl/download"), headers: headers);

    if (res.statusCode != 200) return _handleFillNoteContentErrors(res, note);

    note.content = res.body;
    note.isLoaded = true;
    Debug.log("Downloaded note content for ${note.title}");
  }

  void _handleFillNoteContentErrors(http.Response res, Note note) {
    if (DropboxHelpers.isResBodyJson(res)) {
      DropboxHelpers.printWrongResBodyFormat();
      return;
    }

    final String error = DropboxHelpers.getErrorSummary(res);

    switch (error) {
      case "path/not_found/":
        NoteHandler.deleteNote(NoteHandler.notes.indexOf(note));
        return;
    }

    note.content = "Loading failed; Error:$error";
  }

  Future<void> upload(Note note) async {
    if (!note.isLoaded) return;
    Map<String, String> dropboxAPIArg = {
      "path": DropboxHelpers.getNoteFilePath(note),
      "mode": "overwrite"
    };

    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Dropbox-API-Arg": jsonEncode(dropboxAPIArg),
      "Content-Type": "application/octet-stream",
      "Accept": "application/octet-stream"
    };

    http.Response res = await http.post(Uri.parse("$_mainUrl/upload"),
        headers: headers, body: utf8.encode(note.content));
    //Map<String, dynamic> responseBody = jsonDecode(res.body);
  }

  Future<void> delete(Note note) async {
    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Content-Type": "application/json",
    };

    Map<String, String> body = {"path": DropboxHelpers.getNoteFilePath(note)};

    http.Response res = await http.post(Uri.parse("$_mainUrl/delete_v2"),
        headers: headers, body: jsonEncode(body));
  }
}
