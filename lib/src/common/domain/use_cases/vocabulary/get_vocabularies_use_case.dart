import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

final getVocabulariesUseCaseProvider = AutoDisposeProvider.family((ref, FilterOptions? filterOptions) {
  return GetVocabulariesUseCase(
    vocabularies: ref.watch(vocabularyProvider(filterOptions)).asData?.value ?? [],
  ).call();
});

class GetVocabulariesUseCase {
  final List<Vocabulary> _vocabularies;

  const GetVocabulariesUseCase({
    required List<Vocabulary> vocabularies,
  }) : _vocabularies = vocabularies;

  List<Vocabulary> call() {
    return _vocabularies;
  }
}
