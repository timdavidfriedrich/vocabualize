import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final deleteAllVocabulariesUseCaseProvider = AutoDisposeProvider((ref) {
  return DeleteAllVocabulariesUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  );
});

class DeleteAllVocabulariesUseCase {
  final VocabularyRepository _vocabularyRepository;

  const DeleteAllVocabulariesUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<void> call() async {
    return _vocabularyRepository.deleteAllVocabularies();
  }
}
