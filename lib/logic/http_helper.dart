import 'dart:io';

import 'package:http/http.dart' as http;

Future<http.Response?> post(String url,
    {Map<String, String>? headers, var body}) async {
  try {
    http.Response response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    return response;
  } on SocketException {}
  return null;
}
