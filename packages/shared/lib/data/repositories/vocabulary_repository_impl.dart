import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _initialLevel = 0.0;
const _initialIntervalMinutes = 5;
const _initialEase = 2.5;

@Injectable(as: VocabularyRepository)
class const VocabularyRepositoryImpl(
  final VocabularyLocalDataSource _localDataSource,
) implements VocabularyRepository {
  @override
  Stream<AppResult<List<Vocabulary>>> watchVocabularies({required int limit}) {
    return _localDataSource
        .watchVocabularies(limit: limit)
        .map((vocabularies) => vocabularies.map((it) => it.toVocabulary()).toList())
        .toAppResult();
  }

  @override
  Stream<AppResult<int>> watchVocabularyCount() =>
      _localDataSource.watchVocabularyCount().toAppResult();

  @override
  Future<AppResult<Vocabulary>> addVocabulary({
    required String source,
    required String target,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  }) async {
    final now = DateTime.now().toUtc();
    final vocabulary = Vocabulary(
      id: const Uuid().v7obj().uuid,
      source: source,
      target: target,
      sourceLanguageCode: sourceLanguageCode,
      targetLanguageCode: targetLanguageCode,
      level: _initialLevel,
      isNovice: true,
      intervalMinutes: _initialIntervalMinutes,
      ease: _initialEase,
      nextReviewAt: now,
      image: const NoImage(),
      createdAt: now,
    );
    try {
      final inserted = await _localDataSource.insertVocabulary(vocabulary.toLocalVocabulary());
      return Success(inserted.toVocabulary());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> deleteVocabulary(String id) async {
    try {
      await _localDataSource.deleteVocabulary(UuidValue.withValidation(id));
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
