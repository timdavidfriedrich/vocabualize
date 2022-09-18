import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  String _sourceLang = "de";
  String _targetLang = "es";
  bool _enableImages = true;
  int _initialInterval = 1440 * 1;
  int _initialNoviceInterval = 1;
  double _initialEase = 2.5;
  double _easeDowngrade = 0.2;
  double _easyBonus = 1.3;
  double _easyLevelFactor = 0.6;
  double _goodLevelFactor = 0.3;
  double _hardLevelFactor = -0.3;

  set sourceLang(String sourceLang) {
    _sourceLang = sourceLang;
    save();
  }

  set targetLang(String targetLang) {
    _targetLang = targetLang;
    save();
  }

  set enableImages(bool enableImages) {
    _enableImages = enableImages;
    save();
  }

  set initialInterval(int initialInterval) {
    _initialInterval = initialInterval;
    save();
  }

  set initialNoviceInterval(int initialNoviceInterval) {
    _initialNoviceInterval = initialNoviceInterval;
    save();
  }

  set initialEase(double initialEase) {
    _initialEase = initialEase;
    save();
  }

  set easeDowngrade(double easeDowngrade) {
    _easeDowngrade = easeDowngrade;
    save();
  }

  set easyBonus(double easyBonus) {
    _easyBonus = easyBonus;
    save();
  }

  set easyLevelFactor(double easyLevelFactor) {
    _easyLevelFactor = easyLevelFactor;
    save();
  }

  set goodLevelFactor(double goodLevelFactor) {
    _goodLevelFactor = goodLevelFactor;
    save();
  }

  set hardLevelFactor(double hardLevelFactor) {
    _hardLevelFactor = hardLevelFactor;
    save();
  }

  String get sourceLang => _sourceLang;
  String get targetLang => _targetLang;
  bool get enableImages => _enableImages;
  int get initialInterval => _initialInterval;
  int get initialNoviceInterval => _initialNoviceInterval;
  double get initialEase => _initialEase;
  double get easeDowngrade => _easeDowngrade;
  double get easyBonus => _easyBonus;
  double get easyLevelFactor => _easyLevelFactor;
  double get goodLevelFactor => _goodLevelFactor;
  double get hardLevelFactor => _hardLevelFactor;

  Future<void> save() async {
    prefs = await SharedPreferences.getInstance();

    /// TODO: Save as JSON
    await prefs.setString("sourceLang", _sourceLang);
    await prefs.setString("targetLang", _targetLang);
    await prefs.setBool("enableImages", _enableImages);
    await prefs.setInt("initialInterval", _initialInterval);
    await prefs.setInt("initialNoviceInterval", _initialNoviceInterval);
    await prefs.setDouble("initialEase", _initialEase);
    await prefs.setDouble("easeDowngrade", _easeDowngrade);
    await prefs.setDouble("easyLevelFactor", _easyLevelFactor);
    await prefs.setDouble("easyBonus", _easyLevelFactor);
    await prefs.setDouble("goodLevelFactor", _goodLevelFactor);
    await prefs.setDouble("hardLevelFactor", _hardLevelFactor);
  }

  Future<void> initSettings() async {
    prefs = await SharedPreferences.getInstance();

    /// TODO: Get from JSON
    _sourceLang = prefs.getString("sourceLang")!;
    _targetLang = prefs.getString("targetLang")!;
    _enableImages = prefs.getBool("enableImages")!;
    _initialInterval = prefs.getInt("initialInterval")!;
    _initialNoviceInterval = prefs.getInt("initialNoviceInterval")!;
    _initialEase = prefs.getDouble("initialEase")!;
    _easeDowngrade = prefs.getDouble("easeDowngrade")!;
    _easyBonus = prefs.getDouble("easyBonus")!;
    _easyLevelFactor = prefs.getDouble("easyLevelFactor")!;
    _goodLevelFactor = prefs.getDouble("goodLevelFactor")!;
    _hardLevelFactor = prefs.getDouble("hardLevelFactor")!;
    notifyListeners();
  }
}
