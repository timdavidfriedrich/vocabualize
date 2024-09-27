import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/translator_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';

final translateUseCaseProvider = Provider((ref) {
  return TranslateUseCase(
    translatorRepository: ref.watch(translatorRepositoryProvider),
  );
});

class TranslateUseCase {
  final TranslatorRepository _translatorRepository;

  const TranslateUseCase({
    required TranslatorRepository translatorRepository,
  }) : _translatorRepository = translatorRepository;

  Future<String> call(String source, {String? sourceLanguageId, String? targetLanguageId}) {
    return _translatorRepository.translate(
      source,
      sourceLanguageId: sourceLanguageId,
      targetLanguageId: targetLanguageId,
    );
  }
}
