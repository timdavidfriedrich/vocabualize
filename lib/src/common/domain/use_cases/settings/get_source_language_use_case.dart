import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final getSourceLanguageUseCaseProvider = AutoDisposeProvider((ref) {
  return GetSourceLanguageUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call();
});

class GetSourceLanguageUseCase {
  final SettingsRepository _settingsRepository;

  const GetSourceLanguageUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<Language> call() async {
    return await _settingsRepository.getSourceLanguage();
  }
}
