import 'package:opnot/logic/debug.dart';
import 'package:http/http.dart' as http;

import '../../data_types/note.dart';

class DropboxHelpers {
  static bool isResBodyJson(final http.Response res) {
    return res.headers["content-type"] != "application/json";
  }

  static void printWrongResBodyFormat(http.Response response) {
    Debug.log("Wrong result body format ${response.body}");
  }

  static getNoteFilePath(Note note) {
    return "/${note.title}.txt";
  }
}
