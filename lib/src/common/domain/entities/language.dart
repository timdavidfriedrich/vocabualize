class Language {
  final String id;
  final String name;
  final String translatorId;
  final String premiumTranslatorId;
  final String speechToTextId;
  final String textToSpeechId;
  final DateTime? created;
  final DateTime? updated;

  const Language({
    this.id = "",
    required this.name,
    required this.translatorId,
    required this.premiumTranslatorId,
    required this.speechToTextId,
    required this.textToSpeechId,
    this.created,
    this.updated,
  });

  /// TODO: apply device language for name (to have the correct language on init)
  /// => Maybe setting this at onboarding will be enough
  factory Language.english() => const Language(
      id: "l4ucqbw6jc5i7bj",
      name: "English",
      translatorId: "en",
      premiumTranslatorId: "EN-US",
      speechToTextId: "en_US",
      textToSpeechId: "en-US");
  factory Language.spanish() => const Language(
      id: "m6m3nliuhu85xny",
      name: "Spanish",
      translatorId: "es",
      premiumTranslatorId: "ES",
      speechToTextId: "es_ES",
      textToSpeechId: "es-ES");
  factory Language.defaultSource() => Language.english();
  factory Language.defaultTarget() => Language.spanish();

  @override
  // ignore: hash_and_equals
  bool operator ==(other) {
    if (other is! Language) return false;
    return name == other.name &&
        translatorId == other.translatorId &&
        speechToTextId == other.speechToTextId &&
        textToSpeechId == other.textToSpeechId;
  }

  @override
  String toString() {
    return "Language(id: $id, name: $name, translatorId: $translatorId, premiumTranslatorId: $premiumTranslatorId, speechToTextId: $speechToTextId, "
        "textToSpeechId: $textToSpeechId, created: $created, updated: $updated)";
  }
}
