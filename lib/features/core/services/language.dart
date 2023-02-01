class Language {
  Language({required this.name, required this.translatorId, required this.speechToTextId, required this.textToSpeechId});

  /// TODO: apply device language for name (to have the correct language on init)
  /// => Maybe setting this at onboarding will be enough
  factory Language.defaultSource() => Language(name: "English", translatorId: "en", speechToTextId: "en_AU", textToSpeechId: "en-US");
  factory Language.defaultTarget() => Language(name: "Spanish", translatorId: "es", speechToTextId: "es_AR", textToSpeechId: "es-ES");

  String name;
  String translatorId;
  String speechToTextId;
  String textToSpeechId;

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
  String toString() => "name: $name, translatorId: $translatorId, speechToTextId: $speechToTextId, textToSpeechId: $textToSpeechId";
}
