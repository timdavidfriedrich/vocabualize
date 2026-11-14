abstract class TextToSpeechDataSource {
  Future<bool> speak({required String text, required List<String> languageCodes});
}
