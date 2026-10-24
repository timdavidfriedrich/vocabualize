import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/domain/entities/processed_image.dart';
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
  final ImageFileDataSource _imageFileDataSource,
) implements VocabularyRepository {
  @override
  Stream<AppResult<List<Vocabulary>>> watchVocabularies({required int limit}) {
    return _localDataSource
        .watchVocabularies(limit: limit)
        .map(
          (vocabularies) => vocabularies
              .map((it) => it.toVocabulary(imagePaths: _imageFileDataSource.imagePaths))
              .toList(),
        )
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
    required ProcessedImage? image,
  }) async {
    final now = DateTime.now().toUtc();
    final imageId = const Uuid().v7obj().uuid;
    try {
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
        image: switch (image) {
          final image? => await _saveImage(imageId, image),
          null => const NoImage(),
        },
        createdAt: now,
      );
      final inserted = await _localDataSource.insertVocabulary(vocabulary.toLocalVocabulary());
      return Success(inserted.toVocabulary(imagePaths: _imageFileDataSource.imagePaths));
    } on Object catch (error) {
      if (image != null) _imageFileDataSource.deleteImage(imageId).ignore();
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<()>> deleteVocabulary(String id) async {
    try {
      final deleted = await _localDataSource.deleteVocabulary(UuidValue.withValidation(id));
      for (final vocabulary in deleted) {
        if (vocabulary.customImageId case final imageId?) {
          await _imageFileDataSource.deleteImage(imageId);
        }
      }
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  Future<CustomImage> _saveImage(String imageId, ProcessedImage image) async {
    await _imageFileDataSource.writeImage(
      imageId,
      full: image.fullBytes,
      thumbnail: image.thumbnailBytes,
    );
    final paths = _imageFileDataSource.imagePaths(imageId);
    return CustomImage(imageId: imageId, fullPath: paths.full, thumbnailPath: paths.thumbnail);
  }
}
