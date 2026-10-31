import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/device_data_source.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/extensions/uuid_extensions.dart';
import 'package:shared/data/mappers/activity_mappers.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/vocabulary_filter_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/data/mappers/vocabulary_overview_mappers.dart';
import 'package:shared/data/models/local_activity_day.dart';
import 'package:shared/data/models/local_image_variant.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_filter.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/entities/vocabulary_image_change.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

@Injectable(as: VocabularyRepository)
class const VocabularyRepositoryImpl(
  final VocabularyLocalDataSource _localDataSource,
  final ImageFileDataSource _imageFileDataSource,
  final DeviceDataSource _deviceDataSource,
) implements VocabularyRepository {
  @override
  Stream<AppResult<List<Vocabulary>>> watchVocabularies({
    required Language language,
    required int limit,
    String? tagId,
    VocabularyFilter filter = emptyVocabularyFilter,
  }) => _withImages(
    _localDataSource.watchVocabularies(
      languageCode: language.toLanguageCode(),
      limit: limit,
      tagId: _uuidOrNull(tagId),
      query: filter.query.trim(),
      levelRanges: [
        for (final level in VocabularyLevel.values)
          if (filter.levels.contains(level)) level.toLocalLevelRange(),
      ],
      isDueOnly: filter.isDueOnly,
    ),
  ).toAppResult();

  @override
  Stream<AppResult<int>> watchVocabularyCount() =>
      _localDataSource.watchVocabularyCount().toAppResult();

  @override
  Stream<AppResult<List<Vocabulary>>> watchRecentVocabularies({
    required Language language,
    required Duration maxAge,
    required int limit,
  }) => _withImages(
    _localDataSource.watchRecentVocabularies(
      languageCode: language.toLanguageCode(),
      maxAge: maxAge,
      limit: limit,
    ),
  ).toAppResult();

  @override
  Stream<AppResult<VocabularyOverview>> watchVocabularyOverview({
    required Set<Language> languages,
    String? tagId,
  }) {
    return _localDataSource
        .watchOverview(
          languageCodes: _languageCodes(languages),
          levelFloors: [for (final level in VocabularyLevel.values) level.floor],
          tagId: _uuidOrNull(tagId),
        )
        .map((overview) => overview.toVocabularyOverview())
        .toAppResult();
  }

  @override
  Future<AppResult<Vocabulary>> addVocabulary({
    required List<Translation> translations,
    required Set<Language> startedLanguages,
    required Set<Language> waitingLanguages,
    required ProcessedImage? image,
    required Set<String> tagIds,
  }) async {
    final now = DateTime.now().toUtc();
    final vocabularyId = const Uuid().v7obj();
    final imageId = const Uuid().v7obj().uuid;
    try {
      final vocabulary = Vocabulary(
        id: vocabularyId.uuid,
        translations: {for (final translation in translations) translation.language: translation},
        progress: {
          for (final language in startedLanguages)
            language: _newProgress(language, ProgressStage.shortTerm, now),
          for (final language in waitingLanguages.difference(startedLanguages))
            language: _newProgress(language, ProgressStage.waiting, now),
        },
        image: switch (image) {
          final image? => await _saveImage(imageId, image),
          null => const NoImage(),
        },
        tagIds: tagIds,
        createdAt: now,
      );
      final inserted = await _localDataSource.insertVocabulary(
        vocabulary.toLocalVocabulary(),
        translations: [
          for (final translation in vocabulary.translations.values)
            translation.toLocalTranslation(vocabularyId: vocabularyId),
        ],
        progress: [
          for (final progress in vocabulary.progress.values)
            progress.toLocalProgress(vocabularyId: vocabularyId),
        ],
        activityDay: await _activityDay(),
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
  Future<AppResult<List<Vocabulary>>> findVocabulariesWithText({
    required Language language,
    required String text,
  }) async {
    try {
      final vocabularies = await _localDataSource.findVocabulariesWithText(
        languageCode: language.toLanguageCode(),
        text: text,
      );
      return Success(await _toVocabularies(vocabularies));
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<int>> countDueItems({
    required Set<Language> languages,
    required DateTime dueBy,
    Set<String> tagIds = const {},
  }) async {
    try {
      return Success(
        await _localDataSource.countDueProgress(
          languageCodes: _languageCodes(languages),
          dueBy: dueBy,
          tagIds: _uuids(tagIds),
        ),
      );
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<List<PracticeItem>>> findDueItems({
    required Set<Language> languages,
    required DateTime dueBy,
    required int? limit,
    Set<String> tagIds = const {},
  }) => _practiceItems(
    () => _localDataSource.findDueProgress(
      languageCodes: _languageCodes(languages),
      dueBy: dueBy,
      limit: limit,
      tagIds: _uuids(tagIds),
    ),
  );

  @override
  Future<AppResult<List<PracticeItem>>> findWaitingItems({
    required Language language,
    required int? limit,
    Set<String> tagIds = const {},
  }) => _practiceItems(
    () => _localDataSource.findWaitingProgress(
      languageCode: language.toLanguageCode(),
      limit: limit,
      tagIds: _uuids(tagIds),
    ),
  );

  @override
  Future<AppResult<List<PracticeItem>>> findStartedItems({
    required Set<Language> languages,
    Set<String> tagIds = const {},
  }) => _practiceItems(
    () => _localDataSource.findStartedProgress(
      languageCodes: _languageCodes(languages),
      tagIds: _uuids(tagIds),
    ),
  );

  @override
  Future<AppResult<List<PracticeItem>>> findItems(List<PracticeItemKey> keys) async {
    try {
      final ids = [
        for (final key in keys)
          UuidValue.withValidation(
            key.vocabularyId,
          ).languageRowId(key.language.toLanguageCode()),
      ];
      final progress = {
        for (final row in await _localDataSource.findProgressByIds(ids.toSet())) row.id: row,
      };
      return Success(await _toPracticeItems([for (final id in ids) ?progress[id]]));
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> recordPractice() async {
    try {
      await _localDataSource.recordPractice(activityDay: await _activityDay());
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> removeFromLanguage({
    required String vocabularyId,
    required Language language,
  }) async {
    try {
      await _localDataSource.deleteProgress(
        languageCode: language.toLanguageCode(),
        vocabularyIds: {UuidValue.withValidation(vocabularyId)},
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  Future<AppResult<List<PracticeItem>>> _practiceItems(
    Future<List<LocalProgress>> Function() query,
  ) async {
    try {
      return Success(await _toPracticeItems(await query()));
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> saveReview({
    required String vocabularyId,
    required Progress progress,
  }) async {
    try {
      await _localDataSource.saveReview(
        progress.toLocalProgress(vocabularyId: UuidValue.withValidation(vocabularyId)),
        activityDay: await _activityDay(),
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<Vocabulary>> updateVocabulary({
    required String id,
    required List<Translation> translations,
    required Set<Language> startedLanguages,
    required Set<Language> waitingLanguages,
    required Set<Language> removedLanguages,
    required VocabularyImageChange image,
    required Set<String> tagIds,
  }) async {
    final now = DateTime.now().toUtc();
    final vocabularyId = UuidValue.withValidation(id);
    final newImageId = const Uuid().v7obj().uuid;
    try {
      final stored = await _localDataSource.findVocabulary(vocabularyId);
      if (stored == null) return const Failure(NotFoundError());
      final current = (await _toVocabularies([stored])).single;
      final newImage = switch (image) {
        KeepImage() => current.image,
        RemoveImage() => const NoImage(),
        ReplaceImage(:final image) => await _saveImage(newImageId, image),
      };
      final updated = await _localDataSource.updateVocabulary(
        current.copyWith(image: newImage).toLocalVocabulary(),
        columns: switch (image) {
          KeepImage() => null,
          RemoveImage() || ReplaceImage() => (t) => [
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
        translations: [
          for (final translation in translations)
            translation.toLocalTranslation(vocabularyId: vocabularyId),
        ],
        addedProgress: [
          for (final language in startedLanguages)
            _newProgress(
              language,
              ProgressStage.shortTerm,
              now,
            ).toLocalProgress(vocabularyId: vocabularyId),
          for (final language in waitingLanguages.difference(startedLanguages))
            _newProgress(
              language,
              ProgressStage.waiting,
              now,
            ).toLocalProgress(vocabularyId: vocabularyId),
        ],
        removedLanguageCodes: _languageCodes(removedLanguages),
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

  Progress _newProgress(Language language, ProgressStage stage, DateTime now) =>
      language.toNewProgress(stage, at: now);

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

  Future<LocalActivityDay> _activityDay() async => LocalActivityDay(
    localDate: DateTime.now().toLocalDateString(),
    deviceId: await _deviceDataSource.readOrCreateDeviceId(),
  );

  Stream<List<Vocabulary>> _withImages(Stream<List<LocalVocabulary>> vocabularies) {
    return vocabularies.switchMap(
      (vocabularies) => _imageFileDataSource.watchChanges().asyncMap(
        (_) => _toVocabularies(vocabularies),
      ),
    );
  }

  Future<List<PracticeItem>> _toPracticeItems(List<LocalProgress> progress) async {
    final vocabularies = await _toVocabularies([
      for (final row in progress) ?row.vocabulary,
    ]);
    final vocabulariesById = {for (final vocabulary in vocabularies) vocabulary.id: vocabulary};
    return [
      for (final row in progress)
        if ((vocabulariesById[row.vocabularyId.uuid], row.languageCode.toLanguage())
            case (
              final vocabulary?,
              final language,
            )
            when language != Language.unknown)
          PracticeItem(vocabulary: vocabulary, language: language),
    ];
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

  Set<String> _languageCodes(Set<Language> languages) => {
    for (final language in languages) language.toLanguageCode(),
  };

  UuidValue? _uuidOrNull(String? id) => id == null ? null : UuidValue.withValidation(id);

  Set<UuidValue> _uuids(Set<String> ids) => {for (final id in ids) UuidValue.withValidation(id)};
}
