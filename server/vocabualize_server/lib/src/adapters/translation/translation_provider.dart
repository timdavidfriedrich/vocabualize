abstract class TranslationProvider {
  Future<List<String>> translate({
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  });
}

class const TranslationFailure(
  final String reason,
) implements Exception {
  @override
  String toString() => "TranslationFailure: $reason";
}
