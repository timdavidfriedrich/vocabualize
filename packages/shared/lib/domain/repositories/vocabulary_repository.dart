import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image_change.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';

abstract class VocabularyRepository {
  Stream<AppResult<List<Vocabulary>>> watchVocabularies({
    required int limit,
    String? tagId,
  });

  Stream<AppResult<List<Vocabulary>>> watchRecentVocabularies({
    required Duration maxAge,
    required int limit,
  });

  Stream<AppResult<VocabularyOverview>> watchVocabularyOverview({String? tagId});

  Future<AppResult<Vocabulary>> addVocabulary({
    required String source,
    required String target,
    required LanguagePair languages,
    required ProcessedImage? image,
    required Set<String> tagIds,
  });

  Future<AppResult<Vocabulary>> findVocabulary(String id);

  Future<AppResult<int>> countDueVocabularies({
    required DateTime dueBy,
    String? tagId,
  });

  Future<AppResult<List<Vocabulary>>> findDueVocabularies({
    required DateTime dueBy,
    required int limit,
    String? tagId,
  });

  Future<AppResult<bool>> hasDueVocabulariesOutside({
    required DateTime dueBy,
    required LanguagePair languages,
    String? tagId,
  });

  Future<AppResult<()>> saveReview(Vocabulary vocabulary);

  Future<AppResult<bool>> hasVocabularyWithSource(String source);

  Future<AppResult<Vocabulary>> updateVocabulary({
    required String id,
    required String source,
    required String target,
    required VocabularyImageChange image,
    required Set<String> tagIds,
  });

  Future<AppResult<()>> deleteVocabulary(String id);
}
