abstract class TranslationProvider {
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  });
}

class const TranslationFailure(
  final String reason,
) implements Exception {
  @override
  String toString() => "TranslationFailure: $reason";
}
