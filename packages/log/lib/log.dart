import 'dart:developer';
import 'package:flutter/foundation.dart';

class Log {
  static const String _debugCode = "\x1B[36m";
  static const String _hintCode = "\x1B[32m";
  static const String _warningCode = "\x1B[33m";
  static const String _errorCode = "\x1B[31m";
  static const String _whiteCode = "\x1B[37m";
  static const String _defaultCode = "\x1B[0m";

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

  static void error(dynamic text, {dynamic exception}) {
    if (kDebugMode) {
      log(
        "$_errorCode ERROR: ${_process(text)}"
        "${exception != null ? ' >> ${_process(exception)}' : ""}",
      );
    }
  }
}
