import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesDataSourceProvider = Provider((ref) {
  final asyncSharedPreferences = SharedPreferencesAsync();
  return SharedPreferencesDataSource(
    sharedPreferences: asyncSharedPreferences,
  );
});

class SharedPreferencesDataSource {
  final SharedPreferencesAsync _sharedPreferences;

  const SharedPreferencesDataSource({
    required SharedPreferencesAsync sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final String _sourceLanguageCodeKey = "key.source.language.code";
  final String _targetLanguageCodeKey = "key.target.language.code";
  final String _areImagesEnabledKey = "key.are.images.enabled";
  final String _usePremiumTranslatorKey = "key.use.premium.translator";
  final String _initialIntervalKey = "key.initial.interval";
  final String _initialNoviceIntervalKey = "key.initial.novice.interval";
  final String _initialEaseKey = "key.initial.ease";
  final String _easeIncreaseKey = "key.ease.increase";
  final String _easeDecreaseKey = "key.ease.decrease";
  final String _easyAnswerBonusKey = "key.easy.answer.bonus";
  final String _goodAnswerBonusKey = "key.good.answer.bonus";
  final String _hardAnswerBonusKey = "key.hard.answer.bonus";
  final String _gatherNotificationTimeHourKey = "key.gather.notification.time.hour";
  final String _gatherNotificationTimeMinuteKey = "key.gather.notification.time.minute";
  final String _practiseNotificationTimeHourKey = "key.practise.notification.time.hour";
  final String _practiseNotificationTimeMinuteKey = "key.practise.notification.time.minute";

  Future<String?> getSourceLanguage() {
    return _sharedPreferences.getString(_sourceLanguageCodeKey);
  }

  Future<void> setSourceLanguage(String sourceLanguageCode) {
    return _sharedPreferences.setString(_sourceLanguageCodeKey, sourceLanguageCode);
  }

  Future<String?> getTargetLanguage() {
    return _sharedPreferences.getString(_targetLanguageCodeKey);
  }

  Future<void> setTargetLanguage(String targetLanguageCode) {
    return _sharedPreferences.setString(_targetLanguageCodeKey, targetLanguageCode);
  }

  Future<bool?> getAreImagesEnabled() {
    return _sharedPreferences.getBool(_areImagesEnabledKey);
  }

  Future<void> setAreImagesEnabled(bool areImagesEnabled) {
    return _sharedPreferences.setBool(_areImagesEnabledKey, areImagesEnabled);
  }

  Future<bool?> getUsePremiumTranslator() {
    return _sharedPreferences.getBool(_usePremiumTranslatorKey);
  }

  Future<void> setUsePremiumTranslator(bool usePremiumTranslator) {
    return _sharedPreferences.setBool(_usePremiumTranslatorKey, usePremiumTranslator);
  }

  Future<int?> getInitialInterval() {
    return _sharedPreferences.getInt(_initialIntervalKey);
  }

  Future<void> setInitialInterval(int initialInterval) {
    return _sharedPreferences.setInt(_initialIntervalKey, initialInterval);
  }

  Future<int?> getInitialNoviceInterval() {
    return _sharedPreferences.getInt(_initialNoviceIntervalKey);
  }

  Future<void> setInitialNoviceInterval(int initialNoviceInterval) {
    return _sharedPreferences.setInt(_initialNoviceIntervalKey, initialNoviceInterval);
  }

  Future<double?> getInitialEase() {
    return _sharedPreferences.getDouble(_initialEaseKey);
  }

  Future<void> setInitialEase(double initialEase) {
    return _sharedPreferences.setDouble(_initialEaseKey, initialEase);
  }

  Future<double?> getEaseIncrease() {
    return _sharedPreferences.getDouble(_easeIncreaseKey);
  }

  Future<void> setEaseIncrease(double easeIncrease) {
    return _sharedPreferences.setDouble(_easeIncreaseKey, easeIncrease);
  }

  Future<double?> getEaseDecrease() {
    return _sharedPreferences.getDouble(_easeDecreaseKey);
  }

  Future<void> setEaseDecrease(double easeDecrease) {
    return _sharedPreferences.setDouble(_easeDecreaseKey, easeDecrease);
  }

  Future<double?> getEasyAnswerBonus() {
    return _sharedPreferences.getDouble(_easyAnswerBonusKey);
  }

  Future<void> setEasyAnswerBonus(double easyAnswerBonus) {
    return _sharedPreferences.setDouble(_easyAnswerBonusKey, easyAnswerBonus);
  }

  Future<double?> getGoodAnswerBonus() {
    return _sharedPreferences.getDouble(_goodAnswerBonusKey);
  }

  Future<void> setGoodAnswerBonus(double goodAnswerBonus) {
    return _sharedPreferences.setDouble(_goodAnswerBonusKey, goodAnswerBonus);
  }

  Future<double?> getHardAnswerBonus() {
    return _sharedPreferences.getDouble(_hardAnswerBonusKey);
  }

  Future<void> setHardAnswerBonus(double hardAnswerBonus) {
    return _sharedPreferences.setDouble(_hardAnswerBonusKey, hardAnswerBonus);
  }

  Future<int?> getGatherNotificationTimeHour() {
    return _sharedPreferences.getInt(_gatherNotificationTimeHourKey);
  }

  Future<void> setGatherNotificationTimeHour(int gatherNotificationTimeHour) {
    return _sharedPreferences.setInt(_gatherNotificationTimeHourKey, gatherNotificationTimeHour);
  }

  Future<int?> getGatherNotificationTimeMinute() {
    return _sharedPreferences.getInt(_gatherNotificationTimeMinuteKey);
  }

  Future<void> setGatherNotificationTimeMinute(int gatherNotificationTimeMinute) {
    return _sharedPreferences.setInt(_gatherNotificationTimeMinuteKey, gatherNotificationTimeMinute);
  }

  Future<int?> getPractiseNotificationTimeHour() {
    return _sharedPreferences.getInt(_practiseNotificationTimeHourKey);
  }

  Future<void> setPractiseNotificationTimeHour(int practiseNotificationTimeHour) {
    return _sharedPreferences.setInt(_practiseNotificationTimeHourKey, practiseNotificationTimeHour);
  }

  Future<int?> getPractiseNotificationTimeMinute() {
    return _sharedPreferences.getInt(_practiseNotificationTimeMinuteKey);
  }

  Future<void> setPractiseNotificationTimeMinute(int practiseNotificationTimeMinute) {
    return _sharedPreferences.setInt(_practiseNotificationTimeMinuteKey, practiseNotificationTimeMinute);
  }
}
