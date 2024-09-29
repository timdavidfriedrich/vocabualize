import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vocabualize/constants/common_constants.dart';
import 'package:vocabualize/constants/due_algorithm_constants.dart';
import 'package:vocabualize/constants/notification_constants.dart';
import 'package:vocabualize/src/common/data/data_sources/shared_preferences_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/language_mappers.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferencesDataSource _sharedPreferencesDataSource;

  SettingsRepositoryImpl({
    required SharedPreferencesDataSource sharedPreferencesDataSource,
  }) : _sharedPreferencesDataSource = sharedPreferencesDataSource;

  @override
  Future<Language> getSourceLanguage() async {
    final data = await _sharedPreferencesDataSource.getSourceLanguage();
    if (data == null) {
      return Language.defaultSource();
    }
    final Map<String, dynamic> json = jsonDecode(data);
    return json.toLanguage();
  }

  @override
  Future<void> setSourceLanguage(Language language) async {
    final json = language.toJson();
    final data = jsonEncode(json);
    _sharedPreferencesDataSource.setSourceLanguage(data);
  }

  @override
  Future<Language> getTargetLanguage() async {
    final data = await _sharedPreferencesDataSource.getTargetLanguage();
    if (data == null) {
      return Language.defaultTarget();
    }
    final Map<String, dynamic> json = jsonDecode(data);
    return json.toLanguage();
  }

  @override
  Future<void> setTargetLanguage(Language language) async {
    final json = language.toJson();
    final data = jsonEncode(json);
    _sharedPreferencesDataSource.setTargetLanguage(data);
  }

  @override
  Future<bool> getAreImagesEnabled() async {
    final areImagesEnabled = await _sharedPreferencesDataSource.getAreImagesEnabled();
    return areImagesEnabled ?? CommonConstants.areImagesEnabled;
  }

  @override
  Future<void> setAreImagesEnabled(bool areImagesEnabled) async {
    _sharedPreferencesDataSource.setAreImagesEnabled(areImagesEnabled);
  }

  @override
  Future<bool> getUsePremiumTranslator() async {
    final usePremiumTranslator = await _sharedPreferencesDataSource.getUsePremiumTranslator();
    return usePremiumTranslator ?? CommonConstants.usePremiumTranslator;
  }

  @override
  Future<void> setUsePremiumTranslator(bool usePremiumTranslator) async {
    _sharedPreferencesDataSource.setUsePremiumTranslator(usePremiumTranslator);
  }

  @override
  Future<int> getInitialInterval() async {
    final initialInterval = await _sharedPreferencesDataSource.getInitialInterval();
    return initialInterval ?? DueAlgorithmConstants.initialInterval;
  }

  @override
  Future<void> setInitialInterval(int initialInterval) async {
    _sharedPreferencesDataSource.setInitialInterval(initialInterval);
  }

  @override
  Future<int> getInitialNoviceInterval() async {
    final initialNoviceInterval = await _sharedPreferencesDataSource.getInitialNoviceInterval();
    return initialNoviceInterval ?? DueAlgorithmConstants.initialNoviceInterval;
  }

  @override
  Future<void> setInitialNoviceInterval(int initialNoviceInterval) async {
    _sharedPreferencesDataSource.setInitialNoviceInterval(initialNoviceInterval);
  }

  @override
  Future<double> getInitialEase() async {
    final initialEase = await _sharedPreferencesDataSource.getInitialEase();
    return initialEase ?? DueAlgorithmConstants.initialEase;
  }

  @override
  Future<void> setInitialEase(double initialEase) async {
    _sharedPreferencesDataSource.setInitialEase(initialEase);
  }

  @override
  Future<double> getEaseIncrease() async {
    final easeIncrease = await _sharedPreferencesDataSource.getEaseIncrease();
    return easeIncrease ?? DueAlgorithmConstants.easyIncrease;
  }

  @override
  Future<void> setEaseIncrease(double easeIncrease) async {
    _sharedPreferencesDataSource.setEaseIncrease(easeIncrease);
  }

  @override
  Future<double> getEaseDecrease() async {
    final easeDecrease = await _sharedPreferencesDataSource.getEaseDecrease();
    return easeDecrease ?? DueAlgorithmConstants.easeDecrease;
  }

  @override
  Future<void> setEaseDecrease(double easeDecrease) async {
    _sharedPreferencesDataSource.setEaseDecrease(easeDecrease);
  }

  @override
  Future<double> getEasyAnswerBonus() async {
    final easeAnswerBonus = await _sharedPreferencesDataSource.getEasyAnswerBonus();
    return easeAnswerBonus ?? DueAlgorithmConstants.easyAnswerBonus;
  }

  @override
  Future<void> setEasyAnswerBonus(double easyAnswerBonus) async {
    _sharedPreferencesDataSource.setEasyAnswerBonus(easyAnswerBonus);
  }

  @override
  Future<double> getGoodAnswerBonus() async {
    final goodAnswerBonus = await _sharedPreferencesDataSource.getGoodAnswerBonus();
    return goodAnswerBonus ?? DueAlgorithmConstants.goodAnswerBonus;
  }

  @override
  Future<void> setGoodAnswerBonus(double goodAnswerBonus) async {
    _sharedPreferencesDataSource.setGoodAnswerBonus(goodAnswerBonus);
  }

  @override
  Future<double> getHardAnswerBonus() async {
    final hardAnswerBonus = await _sharedPreferencesDataSource.getHardAnswerBonus();
    return hardAnswerBonus ?? DueAlgorithmConstants.hardAnswerBonus;
  }

  @override
  Future<void> setHardAnswerBonus(double hardAnswerBonus) async {
    _sharedPreferencesDataSource.setHardAnswerBonus(hardAnswerBonus);
  }

  @override
  Future<TimeOfDay> getGatherNotificationTime() async {
    final hour = await _sharedPreferencesDataSource.getGatherNotificationTimeHour();
    final minute = await _sharedPreferencesDataSource.getGatherNotificationTimeMinute();
    if (hour == null) {
      return const TimeOfDay(
        hour: NotificationConstants.gatherNotificationTimeHour,
        minute: NotificationConstants.gatherNotificationTimeMinute,
      );
    }
    if (minute == null) {
      return TimeOfDay(
        hour: hour,
        minute: NotificationConstants.gatherNotificationTimeMinute,
      );
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  Future<void> setGatherNotificationTime(TimeOfDay gatherNotificationTime) async {
    _sharedPreferencesDataSource.setGatherNotificationTimeMinute(gatherNotificationTime.hour);
    _sharedPreferencesDataSource.setGatherNotificationTimeMinute(gatherNotificationTime.minute);
  }

  @override
  Future<TimeOfDay> getPractiseNotificationTime() async {
    final hour = await _sharedPreferencesDataSource.getPractiseNotificationTimeHour();
    final minute = await _sharedPreferencesDataSource.getPractiseNotificationTimeMinute();
    if (hour == null) {
      return const TimeOfDay(
        hour: NotificationConstants.practiseNotificationTimeHour,
        minute: NotificationConstants.practiseNotificationTimeMinute,
      );
    }
    if (minute == null) {
      return TimeOfDay(
        hour: hour,
        minute: NotificationConstants.practiseNotificationTimeMinute,
      );
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  Future<void> setPractiseNotificationTime(TimeOfDay practiseNotificationTime) async {
    _sharedPreferencesDataSource.setPractiseNotificationTimeHour(practiseNotificationTime.hour);
    _sharedPreferencesDataSource.setPractiseNotificationTimeMinute(practiseNotificationTime.minute);
  }
}
