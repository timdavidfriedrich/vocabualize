import 'translation_provider.dart';

class const EchoTranslationProvider() implements TranslationProvider {
  @override
  Future<List<String>> translate({
    required List<String> texts,
    required String sourceLanguage,
    required String targetLanguage,
    required String? context,
  }) async => [for (final text in texts) "$text ($targetLanguage)"];
}
