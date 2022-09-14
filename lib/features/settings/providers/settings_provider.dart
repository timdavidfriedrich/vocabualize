import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  String _sourceLang = "de";
  String _targetLang = "es";
  int _initialInterval = 1440 * 1;
  int _initialNoviceInterval = 1;
  double _easyLevelFactor = 0.6;
  double _goodLevelFactor = 0.3;
  double _hardLevelFactor = -0.3;

  set sourceLang(String sourceLang) {
    this.sourceLang = sourceLang;
    save();
  }

  set targetLang(String targetLang) {
    this.targetLang = targetLang;
    save();
  }

  set initialInterval(int initialInterval) {
    this.initialInterval = initialInterval;
    save();
  }

  set initialNoviceInterval(int initialNoviceInterval) {
    this.initialNoviceInterval = initialNoviceInterval;
    save();
  }

  set easyLevelFactor(double easyLevelFactor) {
    this.easyLevelFactor = easyLevelFactor;
    save();
  }

  set goodLevelFactor(double goodLevelFactor) {
    this.goodLevelFactor = goodLevelFactor;
    save();
  }

  set hardLevelFactor(double hardLevelFactor) {
    this.hardLevelFactor = hardLevelFactor;
    save();
  }

  String get sourceLang => _sourceLang;
  String get targetLang => _targetLang;
  int get initialInterval => _initialInterval;
  int get initialNoviceInterval => _initialNoviceInterval;
  double get easyLevelFactor => _easyLevelFactor;
  double get goodLevelFactor => _goodLevelFactor;
  double get hardLevelFactor => _hardLevelFactor;

  Future<void> save() async {
    prefs = await SharedPreferences.getInstance();

    /// TODO: Save as JSON
    await prefs.setString("sourceLang", _sourceLang);
    await prefs.setString("targetLang", _targetLang);
    await prefs.setInt("initialInterval", _initialInterval);
    await prefs.setInt("initialNoviceInterval", _initialNoviceInterval);
    await prefs.setDouble("easyLevelFactor", _easyLevelFactor);
    await prefs.setDouble("goodLevelFactor", _goodLevelFactor);
    await prefs.setDouble("hardLevelFactor", _hardLevelFactor);
  }

  Future<void> initSettings() async {
    prefs = await SharedPreferences.getInstance();

    /// TODO: Get from JSON
    _sourceLang = prefs.getString("sourceLang")!;
    _targetLang = prefs.getString("targetLang")!;
    _initialInterval = prefs.getInt("initialInterval")!;
    _initialNoviceInterval = prefs.getInt("initialNoviceInterval")!;
    _easyLevelFactor = prefs.getDouble("easyLevelFactor")!;
    _goodLevelFactor = prefs.getDouble("goodLevelFactor")!;
    _hardLevelFactor = prefs.getDouble("hardLevelFactor")!;
    notifyListeners();
  }
}
