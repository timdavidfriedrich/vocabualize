import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final deleteVocabularyUseCaseProvider = AutoDisposeProvider.family((ref, Vocabulary vocabulary) {
  return DeleteVocabularyUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  ).call(vocabulary);
});

class DeleteVocabularyUseCase {
  final VocabularyRepository _vocabularyRepository;

  const DeleteVocabularyUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<void> call(Vocabulary vocabulary) async {
    return _vocabularyRepository.deleteVocabulary(vocabulary);
  }
}
