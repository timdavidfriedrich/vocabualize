class RdbTranslationReport {
  final String id;
  final bool done;
  final String source;
  final String target;
  final String sourceLanguage;
  final String targetLanguage;
  final String description;
  final String created;
  final String updated;

  RdbTranslationReport({
    this.id = "",
    required this.done,
    required this.source,
    required this.target,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.description,
    this.created = "",
    this.updated = "",
  });
}
