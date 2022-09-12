import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProv extends ChangeNotifier {
  late SharedPreferences prefs;

  String _sourceLang = "de";
  String _targetLang = "es";
  double _easyFactor = 0.75;
  double _okayFactor = 0.50;
  double _hardFactor = 0.25;

  set sourceLang(String sourceLang) {
    this.sourceLang = sourceLang;
    save();
  }

  set targetLang(String targetLang) {
    this.targetLang = targetLang;
    save();
  }

  set easyFactor(double easyFactor) {
    this.easyFactor = easyFactor;
    save();
  }

  set okayFactor(double okayFactor) {
    this.okayFactor = okayFactor;
    save();
  }

  set hardFactor(double hardFactor) {
    this.hardFactor = hardFactor;
    save();
  }

  String get sourceLang => _sourceLang;
  String get targetLang => _targetLang;
  double get easyFactor => _easyFactor;
  double get okayFactor => _okayFactor;
  double get hardFactor => _hardFactor;

  Future<void> save() async {
    prefs = await SharedPreferences.getInstance();

    /// TODO: Save as JSON
    await prefs.setString("sourceLang", _sourceLang);
    await prefs.setString("targetLang", _targetLang);
    await prefs.setDouble("easyFactor", _easyFactor);
    await prefs.setDouble("okayFactor", _okayFactor);
    await prefs.setDouble("hardFactor", _hardFactor);
  }

  Future<void> initSettings() async {
    prefs = await SharedPreferences.getInstance();

    /// TODO: Get from JSON
    _sourceLang = prefs.getString("sourceLang")!;
    _targetLang = prefs.getString("targetLang")!;
    _easyFactor = prefs.getDouble("easyFactor")!;
    _okayFactor = prefs.getDouble("okayFactor")!;
    _hardFactor = prefs.getDouble("hardFactor")!;
    notifyListeners();
  }
}
