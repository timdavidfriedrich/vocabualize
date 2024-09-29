import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';

abstract interface class SettingsRepository {
  Future<Language> getSourceLanguage();
  Future<void> setSourceLanguage(Language language);

  Future<Language> getTargetLanguage();
  Future<void> setTargetLanguage(Language language);

  Future<bool> getAreImagesEnabled();
  Future<void> setAreImagesEnabled(bool areImagesEnabled);

  Future<bool> getUsePremiumTranslator();
  Future<void> setUsePremiumTranslator(bool usePremiumTranslator);

  Future<int> getInitialInterval();
  Future<void> setInitialInterval(int initialInterval);

  Future<int> getInitialNoviceInterval();
  Future<void> setInitialNoviceInterval(int initialNoviceInterval);

  Future<double> getInitialEase();
  Future<void> setInitialEase(double initialEase);

  Future<double> getEaseIncrease();
  Future<void> setEaseIncrease(double easeIncrease);

  Future<double> getEaseDecrease();
  Future<void> setEaseDecrease(double easeDecrease);

  Future<double> getEasyAnswerBonus();
  Future<void> setEasyAnswerBonus(double easyAnswerBonus);

  Future<double> getGoodAnswerBonus();
  Future<void> setGoodAnswerBonus(double goodAnswerBonus);

  Future<double> getHardAnswerBonus();
  Future<void> setHardAnswerBonus(double hardAnswerBonus);

  Future<TimeOfDay> getGatherNotificationTime();
  Future<void> setGatherNotificationTime(TimeOfDay gatherNotificationTime);

  Future<TimeOfDay> getPractiseNotificationTime();
  Future<void> setPractiseNotificationTime(TimeOfDay practiseNotificationTime);
}
