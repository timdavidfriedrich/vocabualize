import 'dart:typed_data';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/backup_archive_data_source.dart';
import 'package:shared/data/data_sources/backup_file_data_source.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/image_processing_data_source.dart';
import 'package:shared/data/data_sources/local_import_data_source.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/mappers/backup_mappers.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/data/models/local_backup.dart';
import 'package:shared/data/models/local_image_variant.dart';
import 'package:shared/data/models/local_snapshot.dart';
import 'package:shared/domain/entities/backup_import_status.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/repositories/backup_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

@Injectable(as: BackupRepository)
class const BackupRepositoryImpl(
  final DatabaseSessionDataSource _sessions,
  final LocalImportDataSource _importDataSource,
  final ImageFileDataSource _imageFileDataSource,
  final ImageProcessingDataSource _imageProcessingDataSource,
  final BackupArchiveDataSource _archiveDataSource,
  final BackupFileDataSource _fileDataSource,
  final SettingLocalDataSource _settingDataSource,
) implements BackupRepository {
  @override
  Future<AppResult<()>> exportBackup() async {
    try {
      final snapshot = await _sessions.readCurrentSnapshot();
      final imagePaths = await _imageFileDataSource.findImagePaths([
        for (final vocabulary in snapshot.vocabularies) ?vocabulary.customImageId,
      ]);
      final tagIds = <UuidValue, List<String>>{};
      for (final link in snapshot.vocabularyTags) {
        tagIds.putIfAbsent(link.vocabularyId, () => []).add(link.tagId.uuid);
      }
      final images = <String, String>{};
      final missingImages = <String>[];
      final vocabularies = <LocalBackupVocabulary>[];
      for (final row in snapshot.vocabularies) {
        final vocabulary = row.toVocabulary(imagePaths: imagePaths);
        String? imageEntryPath;
        switch (vocabulary.image) {
          case CustomImage(fullPath: final fullPath?):
            imageEntryPath = _archiveDataSource.imageEntryPath(fullPath);
            images[imageEntryPath] = fullPath;
          case CustomImage():
            missingImages.add(vocabulary.id);
          case NoImage() || StockImage():
            break;
        }
        vocabularies.add(
          vocabulary.toLocalBackupVocabulary(
            tagIds: tagIds[row.id] ?? const [],
            imageEntryPath: imageEntryPath,
          ),
        );
      }
      final archivePath = await _archiveDataSource.writeArchive(
        contents: LocalBackupContents(
          vocabularies: vocabularies,
          tags: [for (final tag in snapshot.tags) tag.toLocalBackupTag()],
          activities: [for (final activity in snapshot.activities) activity.toLocalBackupActivity()],
        ),
        images: images,
        missingImages: missingImages,
        settings: (await _settingDataSource.readLanguagePair())
            ?.toLanguagePair()
            ?.toLocalLanguagePairSetting()
            .toLocalBackupSettings(),
      );
      await _fileDataSource.shareArchive(archivePath);
      return const Success(());
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Stream<AppResult<BackupImportStatus>> importBackup() async* {
    final String? archivePath;
    try {
      archivePath = await _fileDataSource.pickArchive();
    } on Object catch (error) {
      yield Failure(UnexpectedError(error.toString()));
      return;
    }
    if (archivePath == null) {
      yield const Success(BackupImportCancelled());
      return;
    }
    LocalBackupArchive? archive;
    final writtenImageIds = <String>[];
    try {
      final openedArchive = await _archiveDataSource.readArchive(archivePath);
      archive = openedArchive;
      final customImages = [
        for (final item in openedArchive.contents.vocabularies)
          if (item.image?.customImagePath case final imagePath?) (item.id, imagePath),
      ];
      final images = <String, VocabularyImage>{};
      yield Success(BackupImportRunning(processedImages: 0, totalImages: customImages.length));
      for (final (index, (vocabularyId, imagePath)) in customImages.indexed) {
        images[vocabularyId] = await _importCustomImage(openedArchive, imagePath, writtenImageIds);
        yield Success(
          BackupImportRunning(processedImages: index + 1, totalImages: customImages.length),
        );
      }
      final snapshot = _toSnapshot(openedArchive, images);
      await _importDataSource.importSnapshot(snapshot);
      yield Success(BackupImportCompleted(importedCount: snapshot.vocabularies.length));
    } on Object catch (error) {
      for (final imageId in writtenImageIds) {
        _imageFileDataSource.deleteImage(imageId).ignore();
      }
      yield Failure(
        error is FormatException ? const InvalidBackupError() : UnexpectedError(error.toString()),
      );
    } finally {
      if (archive != null) _archiveDataSource.deleteArchive(archive).ignore();
      _fileDataSource.clearPickedArchives().ignore();
    }
  }

  LocalSnapshot _toSnapshot(LocalBackupArchive archive, Map<String, VocabularyImage> images) {
    final contents = archive.contents;
    final now = DateTime.now().toUtc();
    final tagsById = {for (final tag in contents.tags) tag.id: tag};
    final tagIds = {for (final tagId in tagsById.keys) tagId: _newId()};
    final vocabularies = <LocalVocabulary>[];
    final vocabularyTags = <LocalVocabularyTag>[];
    for (final item in contents.vocabularies) {
      final vocabularyId = _newId();
      final image = images[item.id] ?? item.image?.toVocabularyImage() ?? const NoImage();
      vocabularies.add(item.toVocabulary(id: vocabularyId.uuid, image: image).toLocalVocabulary());
      for (final tagId in item.tagIds.toSet()) {
        if (tagIds[tagId] case final localTagId?) {
          vocabularyTags.add(
            LocalVocabularyTag(id: _newId(), vocabularyId: vocabularyId, tagId: localTagId),
          );
        }
      }
    }
    return LocalSnapshot(
      vocabularies: vocabularies,
      tags: [
        for (final MapEntry(key: tagId, value: tag) in tagsById.entries)
          if (tagIds[tagId] case final id?) tag.toLocalTag(id: id, createdAt: now),
      ],
      vocabularyTags: vocabularyTags,
      activities: [for (final activity in contents.activities) activity.toLocalActivity(id: _newId())],
      settings: [
        if (archive.manifest.settings?.toLocalLanguagePairSetting() case final pair?
            when pair.toLanguagePair() != null)
          _settingDataSource.createLanguagePair(
            value: pair.toJson(),
            changedAt: archive.manifest.createdAt,
          ),
      ],
    );
  }

  Future<VocabularyImage> _importCustomImage(
    LocalBackupArchive archive,
    String imagePath,
    List<String> writtenImageIds,
  ) async {
    final sourcePath = await _archiveDataSource.findImageFile(archive, imagePath);
    if (sourcePath == null) return const NoImage();
    final ({Uint8List full, Uint8List thumbnail}) processed;
    try {
      processed = await _imageProcessingDataSource.processImage(sourcePath);
    } on Object {
      return const NoImage();
    }
    final imageId = _newId().uuid;
    writtenImageIds.add(imageId);
    final thumbnailPath = await _imageFileDataSource.writeImage(
      imageId,
      LocalImageVariant.thumbnail,
      processed.thumbnail,
    );
    final fullPath = await _imageFileDataSource.writeImage(
      imageId,
      LocalImageVariant.full,
      processed.full,
    );
    return CustomImage(imageId: imageId, fullPath: fullPath, thumbnailPath: thumbnailPath);
  }

  UuidValue _newId() => const Uuid().v7obj();
}
