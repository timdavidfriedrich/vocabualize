import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/features/core/services/language.dart';
import 'package:vocabualize/features/core/services/languages.dart';

class SettingsProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  Language _sourceLanguage = Language.defaultSource();
  Language _targetLanguage = Language.defaultTarget();
  bool _areImagesEnabled = true;
  int _initialInterval = 1440 * 1;
  int _initialNoviceInterval = 1;
  double _initialEase = 2.5;
  double _easeDowngrade = 0.2;
  double _easyBonus = 1.3;
  double _easyLevelFactor = 0.6;
  double _goodLevelFactor = 0.3;
  double _hardLevelFactor = -0.3;

  set sourceLanguage(Language sourceLang) {
    _sourceLanguage = sourceLang;
    save();
    notifyListeners();
  }

  set targetLanguage(Language targetLang) {
    _targetLanguage = targetLang;
    save();
    notifyListeners();
  }

  set areImagesEnabled(bool areImagesEnabled) {
    _areImagesEnabled = areImagesEnabled;
    save();
    notifyListeners();
  }

  set initialInterval(int initialInterval) {
    _initialInterval = initialInterval;
    save();
    notifyListeners();
  }

  set initialNoviceInterval(int initialNoviceInterval) {
    _initialNoviceInterval = initialNoviceInterval;
    save();
    notifyListeners();
  }

  set initialEase(double initialEase) {
    _initialEase = initialEase;
    save();
    notifyListeners();
  }

  set easeDowngrade(double easeDowngrade) {
    _easeDowngrade = easeDowngrade;
    save();
    notifyListeners();
  }

  set easyBonus(double easyBonus) {
    _easyBonus = easyBonus;
    save();
    notifyListeners();
  }

  set easyLevelFactor(double easyLevelFactor) {
    _easyLevelFactor = easyLevelFactor;
    save();
    notifyListeners();
  }

  set goodLevelFactor(double goodLevelFactor) {
    _goodLevelFactor = goodLevelFactor;
    save();
    notifyListeners();
  }

  set hardLevelFactor(double hardLevelFactor) {
    _hardLevelFactor = hardLevelFactor;
    save();
    notifyListeners();
  }

  Language get sourceLanguage => _sourceLanguage;
  Language get targetLanguage => _targetLanguage;
  bool get areImagesEnabled => _areImagesEnabled;
  bool get areImagesDisabled => !_areImagesEnabled;
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

    await prefs.setString("sourceLanguage", _sourceLanguage.translatorId);
    await prefs.setString("targetLanguage", _targetLanguage.translatorId);
    await prefs.setBool("areImagesEnabled", _areImagesEnabled);
    await prefs.setInt("initialInterval", _initialInterval);
    await prefs.setInt("initialNoviceInterval", _initialNoviceInterval);
    await prefs.setDouble("initialEase", _initialEase);
    await prefs.setDouble("easeDowngrade", _easeDowngrade);
    await prefs.setDouble("easyLevelFactor", _easyLevelFactor);
    await prefs.setDouble("easyBonus", _easyLevelFactor);
    await prefs.setDouble("goodLevelFactor", _goodLevelFactor);
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    Language defaultSource = Language.defaultSource();
    Language defaultTarget = Language.defaultTarget();

    if (prefs.getString("sourceLanguage") != null) {
      _sourceLanguage = await Languages.findLanguage(translatorId: prefs.getString("sourceLanguage")) ?? defaultSource;
    }
    if (prefs.getString("targetLanguage") != null) {
      _targetLanguage = await Languages.findLanguage(translatorId: prefs.getString("targetLanguage")) ?? defaultTarget;
    }
    _areImagesEnabled = prefs.getBool("areImagesEnabled") ?? _areImagesEnabled;
    _initialInterval = prefs.getInt("initialInterval") ?? _initialInterval;
    _initialNoviceInterval = prefs.getInt("initialNoviceInterval") ?? _initialNoviceInterval;
    _initialEase = prefs.getDouble("initialEase") ?? _initialEase;
    _easeDowngrade = prefs.getDouble("easeDowngrade") ?? _easeDowngrade;
    _easyBonus = prefs.getDouble("easyBonus") ?? _easyBonus;
    _easyLevelFactor = prefs.getDouble("easyLevelFactor") ?? _easyLevelFactor;
    _goodLevelFactor = prefs.getDouble("goodLevelFactor") ?? _goodLevelFactor;
    _hardLevelFactor = prefs.getDouble("hardLevelFactor") ?? _hardLevelFactor;
    notifyListeners();
  }
}
