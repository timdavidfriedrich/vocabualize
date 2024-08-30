import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class DeleteAllLocalVocabulariesUseCase {
  final _vocabularyRepository = sl.get<VocabularyRepository>();

  Future<void> call() async {
    return _vocabularyRepository.deleteAllLocalVocabularies();
  }
}
