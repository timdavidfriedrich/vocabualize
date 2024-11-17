import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_source_language_use_case.dart';

final setSourceLanguageUseCaseProvider = AutoDisposeProvider.family((ref, Language language) {
  ref.onDispose(() {
    ref.invalidate(getSourceLanguageUseCaseProvider);
  });
  return SetSourceLanguageUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(language);
});

class SetSourceLanguageUseCase {
  final SettingsRepository _settingsRepository;

  const SetSourceLanguageUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<void> call(Language language) => _settingsRepository.setSourceLanguage(language);
}
