import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class UpdateVocabularyUseCase {
  final _vocabularyRepository = sl.get<VocabularyRepository>();

  Future<void> call(Vocabulary vocabulary) async {
    return _vocabularyRepository.updateVocabulary(vocabulary);
  }
}
