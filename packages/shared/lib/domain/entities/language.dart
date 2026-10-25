enum Language { english, german, spanish, french, polish, unknown }

const supportedLanguages = [
  Language.english,
  Language.german,
  Language.spanish,
  Language.french,
  Language.polish,
];

extension LanguageArticles on Language {
  Set<String> get articles => switch (this) {
    Language.english => const {"the", "a", "an"},
    Language.german => const {
      "der",
      "die",
      "das",
      "den",
      "dem",
      "des",
      "ein",
      "eine",
      "einen",
      "einem",
      "einer",
      "eines",
    },
    Language.spanish => const {"el", "la", "los", "las", "un", "una", "unos", "unas"},
    Language.french => const {"le", "la", "les", "l'", "un", "une", "des"},
    Language.polish || Language.unknown => const {},
  };
}
