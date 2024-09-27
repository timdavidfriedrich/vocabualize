import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/translator_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';

final translateToEnglishUseCaseProvider = Provider((ref) {
  return TranslateToEnglishUseCase(
    translatorRepository: ref.watch(translatorRepositoryProvider),
  );
});

class TranslateToEnglishUseCase {
  final TranslatorRepository _translatorRepository;

  const TranslateToEnglishUseCase({
    required TranslatorRepository translatorRepository,
  }) : _translatorRepository = translatorRepository;

  Future<String> call(String source) => _translatorRepository.translateToEnglish(source);
}
