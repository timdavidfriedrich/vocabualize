abstract interface class TranslatorRepository {
  Future<String> translateToEnglish(String source);
  Future<String> translate(String source, {String? sourceLanguageId, String? targetLanguageId});
}
