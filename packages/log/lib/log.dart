import 'package:flutter/foundation.dart';

class Log {
  static String _hintCode = "\x1B[32m";
  static String _warningCode = "\x1B[33m";
  static String _errorCode = "\x1B[31m";
  static String _whiteCode = "\x1B[37m";
  static String _defaultCode = "\x1B[0m";

  static String _process(text) {
    String processedtext = text.toString().replaceAll("\n", "\n$_whiteCode");
    return "$_whiteCode$processedtext$_defaultCode";
  }

  static void hint(text) {
    if (kDebugMode) print("$_hintCode HINT: ${_process(text)}");
  }

  static void warning(text) {
    if (kDebugMode) print("$_warningCode WARN: ${_process(text)}");
  }

  static void error(text) {
    if (kDebugMode) print("$_errorCode ERROR: ${_process(text)}");
  }
}
