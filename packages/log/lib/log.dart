import 'dart:developer';
import 'package:flutter/foundation.dart';

class Log {
  static String _debugCode = "\x1B[36m";
  static String _hintCode = "\x1B[32m";
  static String _warningCode = "\x1B[33m";
  static String _errorCode = "\x1B[31m";
  static String _whiteCode = "\x1B[37m";
  static String _defaultCode = "\x1B[0m";

  static String _process(text) {
    String processedtext = text.toString().replaceAll("\n", "\n$_whiteCode");
    return "$_whiteCode$processedtext$_defaultCode";
  }

  static void debug(text) {
    if (kDebugMode) log("$_debugCode DEBUG: ${_process(text)}");
  }

  static void hint(text) {
    if (kDebugMode) log("$_hintCode HINT: ${_process(text)}");
  }

  static void warning(text) {
    if (kDebugMode) log("$_warningCode WARN: ${_process(text)}");
  }

  static void error(text) {
    if (kDebugMode) log("$_errorCode ERROR: ${_process(text)}");
  }
}
