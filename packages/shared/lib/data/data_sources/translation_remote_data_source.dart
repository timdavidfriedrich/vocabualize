abstract class TranslationRemoteDataSource {
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  });

  Future<List<String>> translateBatch({
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
  });
}
