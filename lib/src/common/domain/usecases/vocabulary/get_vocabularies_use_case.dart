import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

// TODO ARCHITECTURE: How to deal with searchTerm, tag, and other params?
final getVocabulariesUseCaseProvider = AutoDisposeStreamProvider.family((ref, FilterOptions? filterOptions) {
  return GetVocabulariesUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  ).call(filterOptions);
});

class GetVocabulariesUseCase {
  final VocabularyRepository _vocabularyRepository;

  const GetVocabulariesUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Stream<List<Vocabulary>> call(FilterOptions? filterOptions) {
    return _vocabularyRepository.getVocabularies(filterOptions);
  }
}
