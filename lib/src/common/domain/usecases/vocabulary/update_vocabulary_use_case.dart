import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final updateVocabularyUseCaseProvider = Provider.family((ref, Vocabulary vocabulary) {
  return UpdateVocabularyUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  ).call(vocabulary);
});

class UpdateVocabularyUseCase {
  final VocabularyRepository _vocabularyRepository;

  const UpdateVocabularyUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<void> call(Vocabulary vocabulary) async {
    return _vocabularyRepository.updateVocabulary(vocabulary);
  }
}
