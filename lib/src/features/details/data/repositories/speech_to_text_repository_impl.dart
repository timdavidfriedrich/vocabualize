import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/src/features/record/data/sources/speech_to_text_data_source.dart';
import 'package:vocabualize/src/features/details/domain/repositories/speech_to_text_repository.dart';

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
  Future<void> record({
    required String sourceSpeechToTextId,
    required Function(String) onResult,
  }) {
    return _speechToTextDataSource.record(
      sourceSpeechToTextId: sourceSpeechToTextId,
      onResult: onResult,
    );
  }
}
