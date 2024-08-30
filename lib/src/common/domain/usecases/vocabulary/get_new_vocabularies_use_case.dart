import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class GetNewVocabulariesUseCase {
  final _vocabularyRepository = sl.get<VocabularyRepository>();

  Stream<List<Vocabulary>> call() {
    return _vocabularyRepository.getNewVocabularies();
  }
}
