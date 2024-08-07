import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

abstract interface class TextToSpeechRepository {
  Future<List<String>> getLanguages();
  Future<void> setLanguage(Language language);
  Future<void> readOut(Vocabulary vocabulary);
  void stop();
}
