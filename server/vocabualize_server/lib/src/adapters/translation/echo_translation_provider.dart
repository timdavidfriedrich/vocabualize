import 'translation_provider.dart';

class const EchoTranslationProvider() implements TranslationProvider {
  @override
  Future<String> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async => "$text ($targetLanguage)";
}
