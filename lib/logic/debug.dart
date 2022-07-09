import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class Debug {
  static void log(final String msg) {
    if (!kDebugMode) return;
    print("======= Debug:$msg =======");
  }

  static String formatHttpResponse(final http.Response response,
      {final bool doPrint = false}) {
    final String responseStr =
        "code: ${response.statusCode} body: ${response.body}";
    if (doPrint) print(responseStr);
    return responseStr;
  }
}
