import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/utils/logging.dart';

class LangProv extends ChangeNotifier {
  late SharedPreferences prefs;

  String _sourceLang = "de";
  String _targetLang = "es";

  Future<void> initLang() async {
    prefs = await SharedPreferences.getInstance();
    _sourceLang = prefs.getString("sourceLang")!;
    _targetLang = prefs.getString("targetLang")!;
    notifyListeners();
  }

  Future<void> setSourceLang(String sourceLang) async {
    prefs = await SharedPreferences.getInstance();
    _sourceLang = sourceLang;
    if (!await prefs.setString("sourceLang", sourceLang)) {
      printError("setSourceLang");
    }
    notifyListeners();
  }

  Future<void> setTargetLang(String targetLang) async {
    prefs = await SharedPreferences.getInstance();
    _targetLang = targetLang;
    if (!await prefs.setString("targetLang", targetLang)) {
      printError("setTargetLang");
    }
    notifyListeners();
  }

  String get sourceLang => _sourceLang;
  String get targetLang => _targetLang;
}
