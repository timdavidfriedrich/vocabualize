enum Language { english, german, spanish, french, polish, italian, greek, romanian, unknown }

const supportedLanguages = [
  Language.english,
  Language.german,
  Language.spanish,
  Language.french,
  Language.polish,
  Language.italian,
  Language.greek,
  Language.romanian,
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
    Language.italian => const {"il", "lo", "la", "l'", "i", "gli", "le", "un", "uno", "una", "un'"},
    Language.greek => const {
      "ο",
      "η",
      "το",
      "οι",
      "τα",
      "του",
      "της",
      "των",
      "τον",
      "την",
      "τη",
      "τους",
      "τις",
      "ένας",
      "μια",
      "μία",
      "ένα",
      "έναν",
      "ενός",
      "μιας",
    },
    Language.romanian => const {"un", "o", "niște"},
    Language.polish || Language.unknown => const {},
  };
}
