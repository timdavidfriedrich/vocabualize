import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final deleteAllLocalVocabulariesUseCaseProvider = AutoDisposeProvider((ref) {
  return DeleteAllLocalVocabulariesUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  );
});

class DeleteAllLocalVocabulariesUseCase {
  final VocabularyRepository _vocabularyRepository;

  const DeleteAllLocalVocabulariesUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<void> call() async {
    return _vocabularyRepository.deleteAllLocalVocabularies();
  }
}
