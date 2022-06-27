import 'package:flutter/foundation.dart';

class Debug {
  static void log(String msg) {
    if (!kDebugMode) return;
    print(msg);
  }
}
