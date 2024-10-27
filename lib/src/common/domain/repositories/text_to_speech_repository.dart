import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

abstract interface class TextToSpeechRepository {
  Future<List<String>> getLanguages();
  Future<void> setLanguage(String textToSpeechId);
  Future<void> readOut(Vocabulary vocabulary);
  void stop();
}
