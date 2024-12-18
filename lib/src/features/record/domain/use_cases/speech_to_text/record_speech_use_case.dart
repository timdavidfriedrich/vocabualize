import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/features/record/data/repositories/speech_to_text_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/features/record/domain/repositories/speech_to_text_repository.dart';

final recordSpeechUseCaseProvider = AutoDisposeProvider((ref) {
  return RecordSpeechUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
    speechToTextRepository: ref.watch(speechToTextRepositoryProvider),
  );
});

class RecordSpeechUseCase {
  final SettingsRepository _settingsRepository;
  final SpeechToTextRepository _speechToTextRepository;

  const RecordSpeechUseCase({
    required SettingsRepository settingsRepository,
    required SpeechToTextRepository speechToTextRepository,
  })  : _settingsRepository = settingsRepository,
        _speechToTextRepository = speechToTextRepository;

  Future<void> call({required Function(String) onResult}) async {
    final sourceLanguage = await _settingsRepository.getSourceLanguage();
    return await _speechToTextRepository.record(
      sourceSpeechToTextId: sourceLanguage.speechToTextId,
      onResult: onResult,
    );
  }
}
