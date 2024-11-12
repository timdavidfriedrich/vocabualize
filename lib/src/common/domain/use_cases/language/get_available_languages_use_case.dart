import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/language_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';

final getAvailableLanguagesUseCaseProvider = AutoDisposeFutureProvider((ref) {
  return GetAvailableLanguagesUseCase(
    languageRepository: ref.watch(languageRepositoryProvider),
  ).call();
});

class GetAvailableLanguagesUseCase {
  final LanguageRepository _languageRepository;

  const GetAvailableLanguagesUseCase({
    required LanguageRepository languageRepository,
  }) : _languageRepository = languageRepository;

  Future<List<Language>> call() async {
    return _languageRepository.getAvailableLanguages();
  }
}
