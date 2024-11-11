import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

final getVocabulariesToPractiseUseCaseProvider = AutoDisposeProvider.family((ref, Tag? tag) {
  final filterOptions = tag == null ? null : FilterOptions(tag: tag);
  return GetVocabulariesToPractiseUseCase(
    vocabularies: ref.watch(vocabularyProvider(filterOptions)).asData?.value ?? [],
  ).call();
});

class GetVocabulariesToPractiseUseCase {
  final List<Vocabulary> _vocabularies;

  const GetVocabulariesToPractiseUseCase({
    required List<Vocabulary> vocabularies,
  }) : _vocabularies = vocabularies;

  List<Vocabulary> call() {
    return _vocabularies.where((vocabulary) => vocabulary.isDue).toList();
  }
}
