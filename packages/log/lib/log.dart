import 'package:flutter/foundation.dart';

class Log {
  static String _hintCode = "\x1B[32m";
  static String _warningCode = "\x1B[33m";
  static String _errorCode = "\x1B[31m";
  static String _whiteCode = "\x1B[37m";
  static String _defaultCode = "\x1B[0m";

  static String _process(String text) {
    String processedtext = text.replaceAll("\n", "\n$_whiteCode");
    return "$_whiteCode$processedtext$_defaultCode";
  }

  static void hint(String text) {
    if (kDebugMode) print("$_hintCode HINT: ${_process(text)}");
  }

  static void warning(String text) {
    if (kDebugMode) print("$_warningCode WARN: ${_process(text)}");
  }

  static void error(String text) {
    if (kDebugMode) print("$_errorCode ERROR: ${_process(text)}");
  }
}
