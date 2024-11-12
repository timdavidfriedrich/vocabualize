import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';

final getUsePremiumTranslatorUseCaseProvider = AutoDisposeFutureProvider((ref) {
  return GetUsePremiumTranslatorUseCase(
    settingsRepository: ref.watch(settingsRepositoryProvider),
  ).call();
});

class GetUsePremiumTranslatorUseCase {
  final SettingsRepository _settingsRepository;

  const GetUsePremiumTranslatorUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<bool> call() => _settingsRepository.getUsePremiumTranslator();
}
