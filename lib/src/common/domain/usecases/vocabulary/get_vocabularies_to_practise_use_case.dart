import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class GetVocabulariesToPractiseUseCase {
  final _vocabularyRepository = sl.get<VocabularyRepository>();

  Future<List<Vocabulary>> call({Tag? tag}) {
    return _vocabularyRepository.getVocabulariesToPractise(tag: tag);
  }
}
