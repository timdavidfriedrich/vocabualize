import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final getTargetLanguageUseCaseProvider = AutoDisposeProvider((ref) {
  return GetTargetLanguageUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call();
});

class GetTargetLanguageUseCase {
  final SettingsRepository _settingsRepository;

  const GetTargetLanguageUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<Language> call() async {
    return await _settingsRepository.getTargetLanguage();
  }
}
