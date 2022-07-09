import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opnot/logic/debug.dart';
import 'package:opnot/logic/dropbox/dropbox_err.dart';
import 'package:opnot/logic/dropbox/dropbox_helpers.dart';

import '../../data_types/note.dart';
import 'package:http/http.dart' as http;

class DropboxFileManager {
  static const _mainUrl = "https://api.dropboxapi.com/2/files";
  static const _contentUrl = "https://content.dropboxapi.com/2/files";
  late Future<String?> _token;
  bool hasListOfNotes = false;

  void init(Future<String?> token) {
    _token = token;
  }

  Future<List<Note>> getNoteList(BuildContext context) async {
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

    http.Response response = await http.post(Uri.parse("$_mainUrl/list_folder"),
        headers: headers, body: jsonEncode(body));

    if (DropboxErr.hasErrors(response)) {
      DropboxErr.handleSharedErrors(response);
      return List.empty(growable: true);
    }
    Debug.log("Loaded note list");

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    hasListOfNotes = true;
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

    http.Response response =
        await http.post(Uri.parse("$_contentUrl/download"), headers: headers);

    if (DropboxErr.hasErrors(response)) {
      DropboxErr.handleSharedErrors(response);
      DropboxErr.handleFillNoteContentErrors(response, note);
      return;
    }

    note.content = response.body;
    note.isLoaded = true;
    Debug.log("Downloaded note content for ”${note.title}\"");
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

    http.Response response = await http.post(Uri.parse("$_contentUrl/upload"),
        headers: headers, body: utf8.encode(note.content));

    if (DropboxErr.hasErrors(response)) {
      DropboxErr.handleSharedErrors(response);
      return;
    }

    Debug.log("Uploaded note \"${note.title}\"");
  }

  Future<void> delete(Note note) async {
    Map<String, String> headers = {
      "Authorization": "Bearer ${await _token}",
      "Content-Type": "application/json",
    };

    Map<String, String> body = {"path": DropboxHelpers.getNoteFilePath(note)};

    http.Response response = await http.post(Uri.parse("$_mainUrl/delete_v2"),
        headers: headers, body: jsonEncode(body));

    if (DropboxErr.hasErrors(response)) {
      DropboxErr.handleSharedErrors(response);
      return;
    }

    Debug.log("Deleted note \"${note.title}\"");
  }
}
