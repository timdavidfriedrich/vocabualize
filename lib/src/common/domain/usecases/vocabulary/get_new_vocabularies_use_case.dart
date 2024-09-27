import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final getNewVocabulariesUseCaseProvider = StreamProvider((ref) {
  return GetNewVocabulariesUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  ).call();
});

class GetNewVocabulariesUseCase {
  final VocabularyRepository _vocabularyRepository;

  const GetNewVocabulariesUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Stream<List<Vocabulary>> call() {
    return _vocabularyRepository.getNewVocabularies();
  }
}
