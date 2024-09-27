import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final addVocabularyUseCaseProvider = Provider((ref) {
  return AddVocabularyUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  );
});

class AddVocabularyUseCase {
  final VocabularyRepository _vocabularyRepository;

  const AddVocabularyUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<void> call(Vocabulary vocabulary) async {
    return _vocabularyRepository.addVocabulary(vocabulary);
  }
}
