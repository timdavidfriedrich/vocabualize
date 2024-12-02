import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/extensions/iterable_extensions.dart';

final getVocabulariesUseCaseProvider = AutoDisposeProvider((ref) {
  return GetVocabulariesUseCase(
    vocabularies: ref.watch(vocabularyProvider).value ?? [],
  );
});

class GetVocabulariesUseCase {
  final List<Vocabulary> _vocabularies;

  const GetVocabulariesUseCase({
    required List<Vocabulary> vocabularies,
  }) : _vocabularies = vocabularies;

  List<Vocabulary> call({FilterOptions? filterOptions}) {
    return _vocabularies.filterByTag(filterOptions?.tag).filterBySearchTerm(filterOptions?.searchTerm);
  }
}
