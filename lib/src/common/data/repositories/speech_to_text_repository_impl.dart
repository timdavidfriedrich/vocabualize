import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/src/common/data/data_sources/speech_to_text_data_source.dart';
import 'package:vocabualize/src/common/domain/repositories/speech_to_text_repository.dart';

final speechToTextRepositoryProvider = Provider((ref) {
  return SpeechToTextRepositoryImpl(
    speechToTextDataSource: ref.watch(speechToTextDataSourceProvider),
  );
});

class SpeechToTextRepositoryImpl implements SpeechToTextRepository {
  final SpeechToTextDataSource _speechToTextDataSource;

  const SpeechToTextRepositoryImpl({
    required SpeechToTextDataSource speechToTextDataSource,
  }) : _speechToTextDataSource = speechToTextDataSource;

  @override
  Future<List<LocaleName>> getLocales() {
    return _speechToTextDataSource.getLocales();
  }

  @override
  Future<void> record(Function(String) onResult) {
    return _speechToTextDataSource.record(onResult);
  }
}
