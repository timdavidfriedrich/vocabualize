import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/answer.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final answerVocabularyUseCaseProvider = Provider((ref) {
  return AnswerVocabularyUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  );
});

class AnswerVocabularyUseCase {
  final SettingsRepository _settingsRepository;
  final VocabularyRepository _vocabularyRepository;

  const AnswerVocabularyUseCase({
    required SettingsRepository settingsRepository,
    required VocabularyRepository vocabularyRepository,
  })  : _settingsRepository = settingsRepository,
        _vocabularyRepository = vocabularyRepository;

  Future<void> call({
    required Vocabulary vocabulary,
    required Answer answer,
  }) async {
    // Vocabulary is shown for the first time => initial novice interval
    int initialInterval = await _settingsRepository.getInitialInterval();
    int initialNoviceInterval = await _settingsRepository.getInitialNoviceInterval();
    int currentInterval = vocabulary.isNovice && vocabulary.level.value == 0 ? initialNoviceInterval : vocabulary.interval;

    DateTime nextDate = DateTime.now();
    double easyBonus = await _settingsRepository.getEasyAnswerBonus();
    double easeIncrease = await _settingsRepository.getEaseIncrease();
    double easeDecrease = await _settingsRepository.getEaseDecrease();
    double easyAnswerBonus = (vocabulary.isNovice ? 2 : 1) * await _settingsRepository.getEasyAnswerBonus();
    double goodAnswerBonus = (vocabulary.isNovice ? 2 : 1) * await _settingsRepository.getGoodAnswerBonus();
    double hardAnswerBonus = (vocabulary.isNovice ? 0.5 : 1) * await _settingsRepository.getHardAnswerBonus();

    switch (answer) {
      case Answer.forgot:
        DateTime tempDate = DateTime.now().add(Duration(minutes: initialNoviceInterval));
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWithResetProgress();
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      case Answer.hard:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWith(
          interval: (currentInterval * vocabulary.ease).toInt(),
          ease: vocabulary.ease - easeDecrease,
          level: vocabulary.level.copyWith(value: vocabulary.level.value + hardAnswerBonus),
          nextDate: nextDate,
        );
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      case Answer.good:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWith(
          interval: (currentInterval * vocabulary.ease).toInt(),
          level: vocabulary.level.copyWith(value: vocabulary.level.value + goodAnswerBonus),
          nextDate: nextDate,
        );
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      case Answer.easy:
        DateTime tempDate = DateTime.now().add(Duration(minutes: currentInterval));
        nextDate = tempDate;
        final updatedVocabulary = vocabulary.copyWith(
          interval: (currentInterval * vocabulary.ease * easyBonus).toInt(),
          ease: vocabulary.ease + easeIncrease,
          level: vocabulary.level.copyWith(value: vocabulary.level.value + easyAnswerBonus),
          nextDate: nextDate,
        );
        _vocabularyRepository.updateVocabulary(updatedVocabulary);
        break;
      default:
        Log.error("Unknown answer type: $answer");
    }

    if (vocabulary.isNovice && vocabulary.level.value >= (1 - goodAnswerBonus)) {
      final updatedVocabulary = vocabulary.copyWith(
        isNovice: false,
        interval: initialInterval,
      );
      _vocabularyRepository.updateVocabulary(updatedVocabulary);
    }
  }
}
