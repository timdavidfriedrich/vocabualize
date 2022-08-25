import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///* Neue Print-Methoden (Farbig)
void printHint(text) {
  if (kDebugMode) print("\x1B[32m HINT: \x1B[37m$text\x1B[0m");
}

void printWarning(text) {
  if (kDebugMode) print("\x1B[33m WARN: \x1B[37m$text\x1B[0m");
}

void printError(text) {
  if (kDebugMode) print("\x1B[31m ERROR: \x1B[37m$text\x1B[0m");
}
