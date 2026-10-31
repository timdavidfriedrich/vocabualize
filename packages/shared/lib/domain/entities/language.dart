enum Language {
  englishUk,
  englishUs,
  spanishSpain,
  spanishLatinAmerica,
  frenchFrance,
  frenchCanada,
  germanGermany,
  germanSwitzerland,
  polish,
  italian,
  greek,
  romanian,
  unknown,
}

const supportedLanguages = [
  Language.englishUk,
  Language.englishUs,
  Language.spanishSpain,
  Language.spanishLatinAmerica,
  Language.frenchFrance,
  Language.frenchCanada,
  Language.germanGermany,
  Language.germanSwitzerland,
  Language.polish,
  Language.italian,
  Language.greek,
  Language.romanian,
];

enum _LanguageFamily { english, spanish, french, german, polish, italian, greek, romanian, unknown }

extension LanguageFamilies on Language {
  bool isSameLanguageAs(Language other) => _family == other._family;

  _LanguageFamily get _family => switch (this) {
    Language.englishUk || Language.englishUs => _LanguageFamily.english,
    Language.spanishSpain || Language.spanishLatinAmerica => _LanguageFamily.spanish,
    Language.frenchFrance || Language.frenchCanada => _LanguageFamily.french,
    Language.germanGermany || Language.germanSwitzerland => _LanguageFamily.german,
    Language.polish => _LanguageFamily.polish,
    Language.italian => _LanguageFamily.italian,
    Language.greek => _LanguageFamily.greek,
    Language.romanian => _LanguageFamily.romanian,
    Language.unknown => _LanguageFamily.unknown,
  };
}

extension LanguageArticles on Language {
  Set<String> get articles => switch (this) {
    Language.englishUk || Language.englishUs => const {"the", "a", "an"},
    Language.germanGermany || Language.germanSwitzerland => const {
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
    Language.spanishSpain || Language.spanishLatinAmerica => const {"el", "la", "los", "las", "un", "una", "unos", "unas"},
    Language.frenchFrance || Language.frenchCanada => const {"le", "la", "les", "l'", "un", "une", "des"},
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
