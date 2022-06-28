import 'dart:convert';

import 'package:opnot/logic/debug.dart';
import 'package:http/http.dart' as http;

import '../../data_types/note.dart';

class DropboxHelpers {
  static bool isResBodyJson(final http.Response res) {
    return res.headers["content-type"] != "application/json";
  }

  static void printWrongResBodyFormat() {
    Debug.log("Wrong result body format");
  }

  static String getErrorSummary(final http.Response res) {
    final String error = jsonDecode(res.body)["error_summary"];
    return error.replaceAll(RegExp(r"\/(\.\.\.)$"), "");
  }

  static getNoteFilePath(Note note) {
    return "/${note.title}.txt";
  }
}
