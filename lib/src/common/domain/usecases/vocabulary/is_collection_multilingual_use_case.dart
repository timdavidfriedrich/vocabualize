import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class IsCollectionMultilingualUseCase {
  final _vocabularyRepository = sl.get<VocabularyRepository>();

  Future<bool> call() async {
    return _vocabularyRepository.isCollectionMultilingual();
  }
}
