import 'dart:async';

import 'package:vocabualize/constants/common_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/usecases/language/find_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/notification/schedule_gather_notification_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/notification/schedule_practise_notification_use_case.dart';

// ! URGENT
// TODO ARCHITECTURE (URGENT): Remove SettingsProvider and replace with datasource, repo and use cases

class SettingsProvider extends ChangeNotifier {
  final _findLanguage = sl.get<FindLanguageUseCase>();
  final _scheduleGatherNotification = sl.get<ScheduleGatherNotificationUseCase>();
  final _schedulePracticeNotification = sl.get<SchedulePractiseNotificationUseCase>();
  late SharedPreferences prefs;

  Language _sourceLanguage = Language.defaultSource();
  Language _targetLanguage = Language.defaultTarget();
  bool _areImagesEnabled = true;
  bool _usePremiumTranslator = false;
  int _initialInterval = 1440 * 1;
  int _initialNoviceInterval = 1;
  double _initialEase = 2.5;
  double _easeDowngrade = 0.2;
  double _easyUpgrade = 1.3;
  double _easyLevelFactor = 0.6;
  double _goodLevelFactor = 0.3;
  double _hardLevelFactor = -0.3;
  TimeOfDay _gatherNotificationTime = const TimeOfDay(hour: 13, minute: 0);
  TimeOfDay _practiseNotificationTime = const TimeOfDay(hour: 19, minute: 0);

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

  set usePremiumTranslator(bool usePremiumTranslator) {
    _usePremiumTranslator = usePremiumTranslator;
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

  set easyUpgrade(double easeUpgrade) {
    _easyUpgrade = easeUpgrade;
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

  set gatherNotificationTime(TimeOfDay gatherNotificationTime) {
    _gatherNotificationTime = gatherNotificationTime;
    _scheduleGatherNotification();
    save();
    notifyListeners();
  }

  set practiseNotificationTime(TimeOfDay practiseNotificationTime) {
    _practiseNotificationTime = practiseNotificationTime;
    _schedulePracticeNotification();
    save();
    notifyListeners();
  }

  Language get sourceLanguage => _sourceLanguage;
  Language get targetLanguage => _targetLanguage;
  bool get areImagesEnabled => _areImagesEnabled;
  bool get areImagesDisabled => !_areImagesEnabled;
  bool get usePremiumTranslator => _usePremiumTranslator;
  int get initialInterval => _initialInterval;
  int get initialNoviceInterval => _initialNoviceInterval;
  double get initialEase => _initialEase;
  double get easeDowngrade => _easeDowngrade;
  double get easyUpgrade => _easyUpgrade;
  double get easyLevelFactor => _easyLevelFactor;
  double get goodLevelFactor => _goodLevelFactor;
  double get hardLevelFactor => _hardLevelFactor;
  TimeOfDay get gatherNotificationTime => _gatherNotificationTime;
  TimeOfDay get practiseNotificationTime => _practiseNotificationTime;

  Future<void> save() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setString("sourceLanguage", _sourceLanguage.translatorId);
    await prefs.setString("targetLanguage", _targetLanguage.translatorId);
    await prefs.setBool("areImagesEnabled", _areImagesEnabled);
    await prefs.setBool("usePremiumTranslator", _usePremiumTranslator);
    await prefs.setInt("initialInterval", _initialInterval);
    await prefs.setInt("initialNoviceInterval", _initialNoviceInterval);
    await prefs.setDouble("initialEase", _initialEase);
    await prefs.setDouble("easeDowngrade", _easeDowngrade);
    await prefs.setDouble("easyLevelFactor", _easyLevelFactor);
    await prefs.setDouble("easeUpgrade", _easyLevelFactor);
    await prefs.setDouble("goodLevelFactor", _goodLevelFactor);
    await prefs.setInt("gatherNotificationTimeHour", _gatherNotificationTime.hour);
    await prefs.setInt("gatherNotificationTimeMinute", _gatherNotificationTime.minute);
    await prefs.setInt("practiseNotificationTimeHour", _practiseNotificationTime.hour);
    await prefs.setInt("practiseNotificationTimeMinute", _practiseNotificationTime.minute);
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    Language defaultSource = Language.defaultSource();
    Language defaultTarget = Language.defaultTarget();

    if (prefs.getString("sourceLanguage") != null) {
      _sourceLanguage = await _findLanguage(translatorId: prefs.getString("sourceLanguage")) ?? defaultSource;
    }
    if (prefs.getString("targetLanguage") != null) {
      _targetLanguage = await _findLanguage(translatorId: prefs.getString("targetLanguage")) ?? defaultTarget;
    }
    _areImagesEnabled = prefs.getBool("areImagesEnabled") ?? _areImagesEnabled;
    _usePremiumTranslator = prefs.getBool("usePremiumTranslator") ?? _usePremiumTranslator;
    _initialInterval = prefs.getInt("initialInterval") ?? _initialInterval;
    _initialNoviceInterval = prefs.getInt("initialNoviceInterval") ?? _initialNoviceInterval;
    _initialEase = prefs.getDouble("initialEase") ?? _initialEase;
    _easeDowngrade = prefs.getDouble("easeDowngrade") ?? _easeDowngrade;
    _easyUpgrade = prefs.getDouble("easeUpgrade") ?? _easyUpgrade;
    _easyLevelFactor = prefs.getDouble("easyLevelFactor") ?? _easyLevelFactor;
    _goodLevelFactor = prefs.getDouble("goodLevelFactor") ?? _goodLevelFactor;
    _hardLevelFactor = prefs.getDouble("hardLevelFactor") ?? _hardLevelFactor;
    _gatherNotificationTime = TimeOfDay(
      hour: prefs.getInt("gatherNotificationTimeHour") ?? _gatherNotificationTime.hour,
      minute: prefs.getInt("gatherNotificationTimeMinute") ?? _gatherNotificationTime.minute,
    );
    _practiseNotificationTime = TimeOfDay(
      hour: prefs.getInt("practiseNotificationTimeHour") ?? _practiseNotificationTime.hour,
      minute: prefs.getInt("practiseNotificationTimeMinute") ?? _practiseNotificationTime.minute,
    );
    notifyListeners();
  }
}
