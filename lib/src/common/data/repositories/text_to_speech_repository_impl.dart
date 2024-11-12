import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/sources/text_to_speech_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';

final textToSpeechRepositoryProvider = Provider((ref) {
  return TextToSpeechRepositoryImpl(
    textToSpeechDataSource: ref.watch(textToSpeechDataSourceProvider),
  );
});

class TextToSpeechRepositoryImpl implements TextToSpeechRepository {
  final TextToSpeechDataSource _textToSpeechDataSource;

  const TextToSpeechRepositoryImpl({
    required TextToSpeechDataSource textToSpeechDataSource,
  }) : _textToSpeechDataSource = textToSpeechDataSource;

  @override
  Future<List<String>> getLanguages() {
    return _textToSpeechDataSource.getLanguages();
  }

  @override
  Future<void> setLanguage(String textToSpeechId) {
    return _textToSpeechDataSource.setLanguage(textToSpeechId);
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
