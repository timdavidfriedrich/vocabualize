import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_image_change.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';

abstract class VocabularyRepository {
  Stream<AppResult<List<Vocabulary>>> watchVocabularies({
    required Language language,
    required int limit,
    String? tagId,
    VocabularyFilter filter = emptyVocabularyFilter,
  });

  Stream<AppResult<List<Vocabulary>>> watchRecentVocabularies({
    required Language language,
    required Duration maxAge,
    required int limit,
  });

  Stream<AppResult<VocabularyOverview>> watchVocabularyOverview({
    required Set<Language> languages,
    String? tagId,
  });

  Future<AppResult<Vocabulary>> addVocabulary({
    required List<Translation> translations,
    required Set<Language> startedLanguages,
    required Set<Language> waitingLanguages,
    required ProcessedImage? image,
    required Set<String> tagIds,
  });

  Future<AppResult<Vocabulary>> findVocabulary(String id);

  Future<AppResult<List<Vocabulary>>> findVocabulariesWithText({
    required Language language,
    required String text,
  });

  Future<AppResult<int>> countDueItems({
    required Set<Language> languages,
    required DateTime dueBy,
    String? tagId,
  });

  Future<AppResult<List<PracticeItem>>> findDueItems({
    required Set<Language> languages,
    required DateTime dueBy,
    required int limit,
    String? tagId,
  });

  Future<AppResult<()>> saveReview({
    required String vocabularyId,
    required Progress progress,
  });

  Future<AppResult<Vocabulary>> updateVocabulary({
    required String id,
    required List<Translation> translations,
    required Set<Language> startedLanguages,
    required Set<Language> waitingLanguages,
    required Set<Language> removedLanguages,
    required VocabularyImageChange image,
    required Set<String> tagIds,
  });

  Future<AppResult<()>> deleteVocabulary(String id);
}
