import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/constants/global.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/answer.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

final answerVocabularyUseCaseProvider = Provider((ref) {
  return AnswerVocabularyUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  );
});

// TODO ARCHITECTURE: Remove Provider package and use Setings Repository / DataSource instead

class AnswerVocabularyUseCase {
  final VocabularyRepository _vocabularyRepository;

  const AnswerVocabularyUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<void> call({
    required Vocabulary vocabulary,
    required Answer answer,
  }) async {
    // Vocabulary is shown for the first time => initial novice interval
    int currentInterval = vocabulary.isNovice && vocabulary.level.value == 0
        ? provider.Provider.of<SettingsProvider>(Global.context, listen: false).initialNoviceInterval
        : vocabulary.interval;

    DateTime nextDate = DateTime.now();
    double easyBonus = provider.Provider.of<SettingsProvider>(Global.context, listen: false).easyUpgrade;
    double easeDowngrade = provider.Provider.of<SettingsProvider>(Global.context, listen: false).easeDowngrade;
    double easyUpgrade = provider.Provider.of<SettingsProvider>(Global.context, listen: false).easyUpgrade;
    double hardLevelFactor =
        (vocabulary.isNovice ? 0.5 : 1) * provider.Provider.of<SettingsProvider>(Global.context, listen: false).hardLevelFactor;
    double goodLevelFactor =
        (vocabulary.isNovice ? 2 : 1) * provider.Provider.of<SettingsProvider>(Global.context, listen: false).goodLevelFactor;
    double easyLevelFactor =
        (vocabulary.isNovice ? 2 : 1) * provider.Provider.of<SettingsProvider>(Global.context, listen: false).easyLevelFactor;

    switch (answer) {
      case Answer.forgot:
        DateTime tempDate = DateTime.now().add(
          Duration(minutes: provider.Provider.of<SettingsProvider>(Global.context, listen: false).initialNoviceInterval),
        );
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWithResetProgress();
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      case Answer.hard:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWith(
          interval: (currentInterval * vocabulary.ease).toInt(),
          ease: vocabulary.ease - easeDowngrade,
          level: vocabulary.level.copyWith(value: vocabulary.level.value + hardLevelFactor),
          nextDate: nextDate,
        );
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      case Answer.good:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWith(
          interval: (currentInterval * vocabulary.ease).toInt(),
          level: vocabulary.level.copyWith(value: vocabulary.level.value + goodLevelFactor),
          nextDate: nextDate,
        );
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      case Answer.easy:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWith(
          interval: (currentInterval * vocabulary.ease * easyBonus).toInt(),
          ease: vocabulary.ease + easyUpgrade,
          level: vocabulary.level.copyWith(value: vocabulary.level.value + easyLevelFactor),
          nextDate: nextDate,
        );
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      default:
        Log.error("Unknown answer type: $answer");
    }

    if (vocabulary.isNovice && vocabulary.level.value >= (1 - goodLevelFactor)) {
      final updatedVocabulary = vocabulary.copyWith(
        isNovice: false,
        interval: provider.Provider.of<SettingsProvider>(Global.context, listen: false).initialInterval,
      );
      _vocabularyRepository.updateVocabulary(updatedVocabulary);
    }
  }
}
