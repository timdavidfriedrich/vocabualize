import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/language_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';

final getLanguageByIdUseCaseProvider = AutoDisposeProvider((ref) {
  return GetLanguageByIdUseCase(
    languageRepository: ref.watch(languageRepositoryProvider),
  );
});

class GetLanguageByIdUseCase {
  final LanguageRepository _languageRepository;

  const GetLanguageByIdUseCase({
    required LanguageRepository languageRepository,
  }) : _languageRepository = languageRepository;

  Future<Language?> call(String id) async {
    return _languageRepository.getLanguageById(id);
  }
}
