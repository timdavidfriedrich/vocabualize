abstract interface class TranslatorRepository {
  Future<String> translate({
    required String source,
    required String sourceLanguageId,
    required String targetLanguageId,
    required bool usePremiumTranslator,
  });
}
