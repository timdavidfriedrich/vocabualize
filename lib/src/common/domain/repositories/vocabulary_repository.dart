import 'package:vocabualize/src/common/domain/entities/filter_options.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

abstract interface class VocabularyRepository {
  Future<void> addVocabulary(Vocabulary vocabulary);
  Future<void> deleteAllLocalVocabularies();
  Future<void> deleteAllVocabularies();
  Future<void> deleteVocabulary(Vocabulary vocabulary);
  Stream<List<Vocabulary>> getNewVocabularies();
  // TODO: Add filter and sort options
  Stream<List<Vocabulary>> getVocabularies(FilterOptions? filterOptions);
  Future<List<Vocabulary>> getVocabulariesToPractise({Tag? tag});
  Future<bool> isCollectionMultilingual({Tag? tag});
  Future<void> updateVocabulary(Vocabulary vocabulary);
}
