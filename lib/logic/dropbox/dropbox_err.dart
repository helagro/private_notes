import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opnot/logic/debug.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/logic/note_handler.dart';
import 'package:opnot/main.dart';
import 'dart:convert';
import '../../data_types/note.dart';
import 'dropbox_helpers.dart';

class DropboxErr {
  static bool hasErrors(final http.Response response) {
    return response.statusCode != 200;
  }

  static String getErrorSummary(final http.Response res) {
    final String error = jsonDecode(res.body)["error_summary"];
    return error.replaceAll(RegExp(r"\/(\.\.\.)$"), "");
  }

  static void handleSharedErrors(http.Response response) {
    bool isJsonBody = DropboxHelpers.isResBodyJson(response);

    if (!isJsonBody) {
      Debug.formatHttpResponse(response, doPrint: true);
      return;
    }
    String err = getErrorSummary(response);

    switch (err) {
      case "expired_access_token/":
        DropboxHandler.getAuth(); //get token
        break;
      case "invalid_access_token/":
        MyApp.navigatorKey.currentState?.pushNamed("/login");
        break;
      default:
        Debug.formatHttpResponse(response, doPrint: true);
    }
  }

  static void handleFillNoteContentErrors(http.Response res, Note note) {
    if (res.statusCode == 404) {
      Debug.log(
          "Could not find note called \"${note.title}\" in dropbox; ${res.body}");
      NoteHandler.deleteNote(NoteHandler.notes.indexOf(note));
      return;
    }

    note.content = "Loading failed; Error:${Debug.formatHttpResponse(res)}";
  }
}
