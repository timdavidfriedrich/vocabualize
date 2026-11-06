import 'package:feature_details/presentation/details_state.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';

extension DetailsEditingExtensions on DetailsEditing {
  String textOf(Language language) => texts[language]?.text ?? "";

  String get enteredText => textOf(enteredLanguage);

  List<Language> get activeLanguages => [
    for (final learned in setup.active) learned.language,
  ];

  List<Language> get askMeInLanguages => {
    for (final learned in setup.learned)
      if (learned.askMeIn case final askMeIn?
          when askMeIn != setup.main && !setup.isLearning(askMeIn))
        askMeIn,
  }.toList();

  List<Language> get pausedLanguages => [
    for (final learned in setup.paused) learned.language,
  ];

  Set<Language> get shownLanguages => {
    setup.main,
    ...activeLanguages,
    ...askMeInLanguages,
  };

  Set<Language> get missingLanguages => {
    for (final language in {...shownLanguages, ...enabledLanguages})
      if (language != enteredLanguage && textOf(language).isEmpty) language,
  };

  bool get canSave =>
      enteredText.isNotEmpty &&
      enabledLanguages.isNotEmpty &&
      activeLanguages.every(
        (language) => !enabledLanguages.contains(language) || textOf(language).isNotEmpty,
      );

  bool get canEditTexts => runningAction == null && translatingLanguages.isEmpty;

  bool canSwitchOff(Language language) =>
      !enabledLanguages.contains(language) || enabledLanguages.length > 1;

  List<Language> get learnedLanguages => [...activeLanguages, ...pausedLanguages];

  bool get hasSeveralLanguages => learnedLanguages.length + askMeInLanguages.length > 1;

  Language shownLanguage(Language? picked) {
    final candidates = [?picked, setup.selected, ...learnedLanguages];
    return candidates.where(enabledLanguages.contains).firstOrNull ?? setup.main;
  }

  List<Language> shownFlags(Language shown) => [
    if (enabledLanguages.contains(shown)) shown,
    for (final language in learnedLanguages)
      if (language != shown && enabledLanguages.contains(language)) language,
  ];
}
