import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/data/data_sources/text_to_speech_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';

class TextToSpeechRepositoryImpl implements TextToSpeechRepository {
  final _textToSpeechDataSource = sl.get<TextToSpeechDataSource>();

  @override
  Future<List<String>> getLanguages() {
    return _textToSpeechDataSource.getLanguages();
  }

  @override
  Future<void> setLanguage(Language language) {
    return _textToSpeechDataSource.setLanguage(language);
  }

  @override
  Future<void> readOut(Vocabulary vocabulary) {
    return _textToSpeechDataSource.speak(vocabulary);
  }

  @override
  void stop() {
    _textToSpeechDataSource.stop();
  }
}
