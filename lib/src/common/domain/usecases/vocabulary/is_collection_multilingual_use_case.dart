import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final isCollectionMultilingualUseCaseProvider = AutoDisposeProvider((ref) {
  return IsCollectionMultilingualUseCase(
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  ).call();
});

class IsCollectionMultilingualUseCase {
  final VocabularyRepository _vocabularyRepository;

  const IsCollectionMultilingualUseCase({
    required VocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  Future<bool> call() async {
    return _vocabularyRepository.isCollectionMultilingual();
  }
}
