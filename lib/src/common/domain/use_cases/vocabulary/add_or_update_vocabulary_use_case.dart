import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final addOrUpdateVocabularyUseCaseProvider = AutoDisposeProvider.family((ref, Vocabulary vocabulary) {
  return AddOrUpdateVocabularyUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  ).call(vocabulary);
});

class AddOrUpdateVocabularyUseCase {
  final VocabularyRepository _vocabularyRepository;

  const AddOrUpdateVocabularyUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<void> call(Vocabulary vocabulary) async {
    if (vocabulary.id == null) {
      return _vocabularyRepository.addVocabulary(vocabulary);
    }
    return _vocabularyRepository.updateVocabulary(vocabulary);
  }
}
