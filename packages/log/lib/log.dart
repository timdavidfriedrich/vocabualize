import 'package:flutter/foundation.dart';

class Log {
  static void hint(text) {
    if (kDebugMode) print("\x1B[32m HINT: \x1B[37m$text\x1B[0m");
  }

  static void warning(text) {
    if (kDebugMode) print("\x1B[33m WARN: \x1B[37m$text\x1B[0m");
  }

  static void error(text) {
    if (kDebugMode) print("\x1B[31m ERROR: \x1B[37m$text\x1B[0m");
  }
}
