import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/vocabulary.dart';

abstract class VocabularyRepository {
  Stream<AppResult<List<Vocabulary>>> watchVocabularies({required int limit});

  Stream<AppResult<int>> watchVocabularyCount();

  Future<AppResult<Vocabulary>> addVocabulary({
    required String source,
    required String target,
    required LanguagePair languages,
    required ProcessedImage? image,
  });

  Future<AppResult<()>> deleteVocabulary(String id);
}
