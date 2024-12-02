import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_use_premium_translator_use_case.dart';

final setUsePremiumTranslatorUseCaseProvider = AutoDisposeFutureProvider.family((ref, bool value) {
  ref.onDispose(() {
    ref.invalidate(getUsePremiumTranslatorUseCaseProvider);
  });
  return SetUsePremiumTranslatorUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call(value);
});

class SetUsePremiumTranslatorUseCase {
  final SettingsRepository _settingsRepository;

  const SetUsePremiumTranslatorUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<void> call(bool value) => _settingsRepository.setUsePremiumTranslator(value);
}
