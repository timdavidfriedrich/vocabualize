import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

final getNewVocabulariesUseCaseProvider = Provider((ref) {
  return GetNewVocabulariesUseCase(
    vocabularies: ref.watch(vocabularyProvider).asData?.value ?? [],
  ).call();
});

class GetNewVocabulariesUseCase {
  final List<Vocabulary> _vocabularies;

  const GetNewVocabulariesUseCase({
    required List<Vocabulary> vocabularies,
  }) : _vocabularies = vocabularies;

  List<Vocabulary> call() {
    return _vocabularies.reversed.where((vocabulary) => vocabulary.isNew).take(10).toList();
  }
}
