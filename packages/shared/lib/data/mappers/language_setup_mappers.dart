import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/models/local_language_settings.dart';
import 'package:shared/data/models/local_learned_language_setting.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';

const _levelNovice = "novice";
const _levelBeginner = "beginner";
const _levelAdvanced = "advanced";
const _levelExpert = "expert";
const _allNewWords = "all";

extension LocalLanguageSettingsMappers on LocalLanguageSettings {
  LanguageSetup? toLanguageSetup() {
    final main = mainLanguage?.toLanguage();
    final settings = [
      for (final value in learnedLanguages) ?value.toLocalLearnedLanguageSetting(),
    ]..sort((first, second) => first.addedAt.compareTo(second.addedAt));
    final learned = [
      for (final setting in settings)
        if (setting.toLearnedLanguage() case final learnedLanguage?
            when learnedLanguage.language != main)
          learnedLanguage,
    ];
    if (main == null || main == Language.unknown || learned.isEmpty) return null;
    final active = [
      for (final learnedLanguage in learned)
        if (!learnedLanguage.isPaused) learnedLanguage.language,
    ];
    return LanguageSetup(
      main: main,
      learned: learned,
      selected: switch (selectedLanguage?.toLanguage()) {
        final selected? when active.contains(selected) => selected,
        _ => active.firstOrNull ?? learned.first.language,
      },
    );
  }
}

extension LocalLearnedLanguageSettingMappers on LocalLearnedLanguageSetting {
  LearnedLanguage? toLearnedLanguage() {
    final learned = language.toLanguage();
    if (learned == Language.unknown) return null;
    final askMeInLanguage = askMeIn?.toLanguage();
    return LearnedLanguage(
      language: learned,
      askMeIn: askMeInLanguage == Language.unknown ? null : askMeInLanguage,
      askMeInFromLevel: askMeInFromLevel.toVocabularyLevel(),
      newWords: newWords.toNewWordLimit(),
      isPaused: isPaused,
    );
  }
}

extension LearnedLanguageMappers on LearnedLanguage {
  LocalLearnedLanguageSetting toLocalLearnedLanguageSetting({required DateTime addedAt}) {
    return LocalLearnedLanguageSetting(
      language: language.toLanguageCode(),
      askMeIn: askMeIn?.toLanguageCode(),
      askMeInFromLevel: askMeInFromLevel.value,
      newWords: newWords.value,
      isPaused: isPaused,
      addedAt: addedAt.toUtc(),
    );
  }
}

extension LearnedLanguageValueMappers on String {
  LocalLearnedLanguageSetting? toLocalLearnedLanguageSetting() {
    try {
      return LocalLearnedLanguageSettingMapper.fromJson(this);
    } on MapperException {
      return null;
    }
  }

  VocabularyLevel toVocabularyLevel() => switch (this) {
    _levelNovice => VocabularyLevel.novice,
    _levelBeginner => VocabularyLevel.beginner,
    _levelExpert => VocabularyLevel.expert,
    _ => VocabularyLevel.advanced,
  };

  NewWordLimit toNewWordLimit() => switch (this) {
    _allNewWords => const AllNewWords(),
    _ => switch (int.tryParse(this)) {
      final count? when count > 0 => NewWordsUpTo(count: count),
      _ => defaultNewWordLimit,
    },
  };
}

extension VocabularyLevelValueMappers on VocabularyLevel {
  String get value => switch (this) {
    VocabularyLevel.novice => _levelNovice,
    VocabularyLevel.beginner => _levelBeginner,
    VocabularyLevel.advanced => _levelAdvanced,
    VocabularyLevel.expert => _levelExpert,
  };
}

extension NewWordLimitMappers on NewWordLimit {
  String get value => switch (this) {
    NewWordsUpTo(:final count) => "$count",
    AllNewWords() => _allNewWords,
  };
}
