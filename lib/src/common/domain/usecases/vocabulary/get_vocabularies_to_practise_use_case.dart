import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final getVocabulariesToPractiseUseCaseProvider = AutoDisposeProvider.family((ref, Tag? tag) {
  return GetVocabulariesToPractiseUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  ).call(tag: tag);
});

class GetVocabulariesToPractiseUseCase {
  final VocabularyRepository _vocabularyRepository;

  const GetVocabulariesToPractiseUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<List<Vocabulary>> call({Tag? tag}) {
    return _vocabularyRepository.getVocabulariesToPractise(tag: tag);
  }
}
