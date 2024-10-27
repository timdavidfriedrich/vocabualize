import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/text_to_speech_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';
import 'package:vocabualize/src/common/domain/usecases/settings/get_target_language_use_case.dart';

final setTargetLanguageUseCaseProvider = AutoDisposeProvider.family((ref, Language language) {
  ref.onDispose(() {
    ref.invalidate(getTargetLanguageUseCaseProvider);
  });
  return SetTargetLanguageUseCase(
    textToSpeechRepository: ref.watch(textToSpeechRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(language);
});

class SetTargetLanguageUseCase {
  final SettingsRepository _settingsRepository;
  final TextToSpeechRepository _textToSpeechRepository;

  const SetTargetLanguageUseCase({
    required SettingsRepository settingsRepository,
    required TextToSpeechRepository textToSpeechRepository,
  })  : _settingsRepository = settingsRepository,
        _textToSpeechRepository = textToSpeechRepository;

  Future<void> call(Language language) {
    _textToSpeechRepository.setLanguage(language.textToSpeechId);
    return _settingsRepository.setTargetLanguage(language);
  }
}
