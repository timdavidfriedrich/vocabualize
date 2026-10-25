import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/activity_mappers.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/data/mappers/vocabulary_overview_mappers.dart';
import 'package:shared/data/models/local_image_variant.dart';
import 'package:shared/domain/entities/activity_type.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/entities/vocabulary_image_change.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
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
  Stream<AppResult<List<Vocabulary>>> watchVocabularies({
    required int limit,
    String? tagId,
  }) => _withImages(
    _localDataSource.watchVocabularies(limit: limit, tagId: _uuidOrNull(tagId)),
  ).toAppResult();

  @override
  Stream<AppResult<List<Vocabulary>>> watchRecentVocabularies({
    required Duration maxAge,
    required int limit,
  }) => _withImages(
    _localDataSource.watchRecentVocabularies(maxAge: maxAge, limit: limit),
  ).toAppResult();

  @override
  Stream<AppResult<VocabularyOverview>> watchVocabularyOverview({String? tagId}) {
    return _localDataSource
        .watchOverview(
          levelFloors: [for (final level in VocabularyLevel.values) level.floor],
          tagId: _uuidOrNull(tagId),
        )
        .map((overview) => overview.toVocabularyOverview())
        .toAppResult();
  }

  @override
  Future<AppResult<Vocabulary>> addVocabulary({
    required String source,
    required String target,
    required LanguagePair languages,
    required ProcessedImage? image,
    required Set<String> tagIds,
  }) async {
    final now = DateTime.now().toUtc();
    final imageId = const Uuid().v7obj().uuid;
    try {
      final vocabulary = Vocabulary(
        id: const Uuid().v7obj().uuid,
        source: source,
        target: target,
        sourceLanguage: languages.source,
        targetLanguage: languages.target,
        level: _initialLevel,
        isNovice: true,
        intervalMinutes: _initialIntervalMinutes,
        ease: _initialEase,
        nextReviewAt: now,
        image: switch (image) {
          final image? => await _saveImage(imageId, image),
          null => const NoImage(),
        },
        tagIds: tagIds,
        createdAt: now,
      );
      final inserted = await _localDataSource.insertVocabulary(
        vocabulary.toLocalVocabulary(),
        activity: _activity(ActivityType.add),
        tagIds: _uuids(tagIds),
      );
      return Success((await _toVocabularies([inserted])).single);
    } on Object catch (error) {
      if (image != null) _imageFileDataSource.deleteImage(imageId).ignore();
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<Vocabulary>> findVocabulary(String id) async {
    try {
      final vocabulary = await _localDataSource.findVocabulary(UuidValue.withValidation(id));
      if (vocabulary == null) return const Failure(NotFoundError());
      return Success((await _toVocabularies([vocabulary])).single);
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<int>> countDueVocabularies({
    required DateTime dueBy,
    String? tagId,
  }) async {
    try {
      return Success(
        await _localDataSource.countDueVocabularies(dueBy: dueBy, tagId: _uuidOrNull(tagId)),
      );
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<List<Vocabulary>>> findDueVocabularies({
    required DateTime dueBy,
    required int limit,
    String? tagId,
  }) async {
    try {
      final vocabularies = await _localDataSource.findDueVocabularies(
        dueBy: dueBy,
        limit: limit,
        tagId: _uuidOrNull(tagId),
      );
      return Success(await _toVocabularies(vocabularies));
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<bool>> hasDueVocabulariesOutside({
    required DateTime dueBy,
    required LanguagePair languages,
    String? tagId,
  }) async {
    try {
      return Success(
        await _localDataSource.hasDueVocabulariesOutsidePair(
          dueBy: dueBy,
          sourceLanguageCode: languages.source.toLanguageCode(),
          targetLanguageCode: languages.target.toLanguageCode(),
          tagId: _uuidOrNull(tagId),
        ),
      );
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> saveReview(Vocabulary vocabulary) async {
    try {
      await _localDataSource.saveReview(
        vocabulary.toLocalVocabulary(),
        activity: _activity(ActivityType.practice),
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<bool>> hasVocabularyWithSource(String source) async {
    try {
      return Success(await _localDataSource.hasVocabularyWithSource(source));
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<Vocabulary>> updateVocabulary({
    required String id,
    required String source,
    required String target,
    required VocabularyImageChange image,
    required Set<String> tagIds,
  }) async {
    final newImageId = const Uuid().v7obj().uuid;
    try {
      final stored = await _localDataSource.findVocabulary(UuidValue.withValidation(id));
      if (stored == null) return const Failure(NotFoundError());
      final current = (await _toVocabularies([stored])).single;
      final newImage = switch (image) {
        KeepImage() => current.image,
        RemoveImage() => const NoImage(),
        ReplaceImage(:final image) => await _saveImage(newImageId, image),
      };
      final updated = await _localDataSource.updateVocabulary(
        current.copyWith(source: source, target: target, image: newImage).toLocalVocabulary(),
        columns: (t) => switch (image) {
          KeepImage() => [t.source, t.target],
          RemoveImage() || ReplaceImage() => [
            t.source,
            t.target,
            t.imageKind,
            t.customImageId,
            t.customImageUploadedAt,
            t.stockImageId,
            t.stockImageUrl,
            t.stockImageThumbUrl,
            t.stockPhotographer,
            t.stockPhotographerUrl,
          ],
        },
        tagIds: _uuids(tagIds),
      );
      if ((image, stored.customImageId) case (RemoveImage() || ReplaceImage(), final oldId?)) {
        await _imageFileDataSource.deleteImage(oldId);
      }
      return Success((await _toVocabularies([updated])).single);
    } on Object catch (error) {
      if (image is ReplaceImage) _imageFileDataSource.deleteImage(newImageId).ignore();
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
    return CustomImage(
      imageId: imageId,
      fullPath: fullPath,
      thumbnailPath: thumbnailPath,
      photographer: image.photographer,
      photographerUrl: image.photographerUrl,
    );
  }

  LocalActivity _activity(ActivityType type) {
    final now = DateTime.now();
    return LocalActivity(
      id: const Uuid().v7obj(),
      type: type.value,
      localDate: now.toLocalDateString(),
      occurredAt: now.toUtc(),
    );
  }

  Stream<List<Vocabulary>> _withImages(Stream<List<LocalVocabulary>> vocabularies) {
    return vocabularies.switchMap(
      (vocabularies) => _imageFileDataSource.watchChanges().asyncMap(
        (_) => _toVocabularies(vocabularies),
      ),
    );
  }

  Future<List<Vocabulary>> _toVocabularies(List<LocalVocabulary> vocabularies) async {
    final imagePaths = await _imageFileDataSource.findImagePaths([
      for (final vocabulary in vocabularies) ?vocabulary.customImageId,
    ]);
    final links = await _localDataSource.findTagLinks({
      for (final vocabulary in vocabularies) ?vocabulary.id,
    });
    final tagIds = <UuidValue, Set<String>>{};
    for (final link in links) {
      tagIds.putIfAbsent(link.vocabularyId, () => {}).add(link.tagId.uuid);
    }
    return [
      for (final vocabulary in vocabularies)
        vocabulary.toVocabulary(
          imagePaths: imagePaths,
          tagIds: tagIds[vocabulary.id] ?? const {},
        ),
    ];
  }

  UuidValue? _uuidOrNull(String? id) => id == null ? null : UuidValue.withValidation(id);

  Set<UuidValue> _uuids(Set<String> ids) => {for (final id in ids) UuidValue.withValidation(id)};
}
