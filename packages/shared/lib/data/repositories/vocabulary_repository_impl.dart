import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/data/models/local_image_variant.dart';
import 'package:shared/domain/entities/language_pair.dart';
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
        .switchMap(
          (vocabularies) => _imageFileDataSource.watchChanges().asyncMap(
            (_) => _toVocabularies(vocabularies),
          ),
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
    required LanguagePair languages,
    required ProcessedImage? image,
  }) async {
    final now = DateTime.now().toUtc();
    final imageId = const Uuid().v7obj().uuid;
    try {
      final vocabulary = Vocabulary(
        id: const Uuid().v7obj().uuid,
        source: source,
        target: target,
        sourceLanguageCode: languages.source.toLanguageCode(),
        targetLanguageCode: languages.target.toLanguageCode(),
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
      return Success((await _toVocabularies([inserted])).single);
    } on Object catch (error) {
      if (image != null) _imageFileDataSource.deleteImage(imageId).ignore();
      return Failure(error.toAppError());
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
      return Failure(error.toAppError());
    }
  }

  Future<CustomImage> _saveImage(String imageId, ProcessedImage image) async {
    final thumbnailPath = await _imageFileDataSource.writeImage(
      imageId,
      LocalImageVariant.thumbnail,
      image.thumbnailBytes,
    );
    final fullPath = await _imageFileDataSource.writeImage(
      imageId,
      LocalImageVariant.full,
      image.fullBytes,
    );
    return CustomImage(imageId: imageId, fullPath: fullPath, thumbnailPath: thumbnailPath);
  }

  Future<List<Vocabulary>> _toVocabularies(List<LocalVocabulary> vocabularies) async {
    final imagePaths = await _imageFileDataSource.findImagePaths([
      for (final vocabulary in vocabularies) ?vocabulary.customImageId,
    ]);
    return [
      for (final vocabulary in vocabularies) vocabulary.toVocabulary(imagePaths: imagePaths),
    ];
  }
}
