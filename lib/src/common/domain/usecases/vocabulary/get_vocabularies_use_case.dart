import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class GetVocabulariesUseCase {
  final _vocabularyRepository = sl.get<VocabularyRepository>();

  Stream<List<Vocabulary>> call({String? searchTerm, Tag? tag}) {
    return _vocabularyRepository.getVocabularies(
      searchTerm: searchTerm,
      tag: tag,
    );
  }
}
