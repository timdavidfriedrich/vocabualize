import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod_database/serverpod_database.dart';
import 'package:serverpod_offline_sync_client/serverpod_offline_sync_client.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/image_transfer_data_source.dart';
import 'package:shared/data/data_sources/sync_data_source.dart';
import 'package:shared/data/models/local_image_variant.dart';
import 'package:shared/data/models/remote_sync_state.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class ImageSyncDataSource {
  void start(OfflineSyncDatabaseSession session);

  Future<void> stop();

  Future<bool> uploadPending(OfflineSyncDatabaseSession session);

  Stream<bool> watchTransferring();
}

@LazySingleton(as: ImageSyncDataSource)
class ImageSyncDataSourceImpl(
  final SyncDataSource _syncDataSource,
  final DatabaseSessionDataSource _sessions,
  final ImageFileDataSource _imageFileDataSource,
  final ImageTransferDataSource _imageTransferDataSource,
) implements ImageSyncDataSource {
  OfflineSyncDatabaseSession? _session;
  StreamSubscription<RemoteSyncState>? _stateSubscription;
  StreamSubscription<List<LocalVocabulary>>? _pendingUploadsSubscription;
  StreamSubscription<int>? _uploadedCountSubscription;
  bool _isUploadRequested = false;
  bool _isDownloadRequested = false;
  bool _isTransferring = false;
  final _transferringChanges = StreamController<bool>.broadcast();
  int _activeTransfers = 0;

  @override
  Stream<bool> watchTransferring() async* {
    yield _activeTransfers > 0;
    yield* _transferringChanges.stream;
  }

  @override
  void start(OfflineSyncDatabaseSession session) {
    if (identical(_session, session)) return;
    unawaited(_cancelSubscriptions());
    _session = session;
    _stateSubscription = _syncDataSource.watchState().listen(
      (state) => state == RemoteSyncState.live ? _watchTransfers(session) : _unwatchTransfers(),
    );
  }

  @override
  Future<void> stop() async {
    _session = null;
    _isUploadRequested = false;
    _isDownloadRequested = false;
    await _cancelSubscriptions();
  }

  @override
  Future<bool> uploadPending(OfflineSyncDatabaseSession session) async {
    try {
      return await _uploadPending(session);
    } on Object {
      return false;
    }
  }

  void _watchTransfers(OfflineSyncDatabaseSession session) {
    _pendingUploadsSubscription ??= LocalVocabulary.db
        .watch(session, where: _isPendingUpload)
        .listen((vocabularies) {
          if (vocabularies.isNotEmpty) _request(upload: true);
        });
    _uploadedCountSubscription ??= LocalVocabulary.db
        .watch(session, where: _isUploaded, limit: 1)
        .asyncMap((_) => LocalVocabulary.db.count(session, where: _isUploaded))
        .distinct()
        .listen((_) => _request(download: true));
  }

  void _unwatchTransfers() {
    final pendingUploadsSubscription = _pendingUploadsSubscription;
    final uploadedCountSubscription = _uploadedCountSubscription;
    _pendingUploadsSubscription = null;
    _uploadedCountSubscription = null;
    unawaited(pendingUploadsSubscription?.cancel());
    unawaited(uploadedCountSubscription?.cancel());
  }

  Future<void> _cancelSubscriptions() async {
    final stateSubscription = _stateSubscription;
    _stateSubscription = null;
    _unwatchTransfers();
    await stateSubscription?.cancel();
  }

  void _request({bool upload = false, bool download = false}) {
    _isUploadRequested = _isUploadRequested || upload;
    _isDownloadRequested = _isDownloadRequested || download;
    if (!_isTransferring) unawaited(_transfer());
  }

  Future<void> _transfer() async {
    _isTransferring = true;
    try {
      while (_isUploadRequested || _isDownloadRequested) {
        final session = _session;
        if (session == null) break;
        if (_isUploadRequested) {
          _isUploadRequested = false;
          await _uploadPending(session);
        } else {
          _isDownloadRequested = false;
          await _downloadMissing(session);
        }
      }
    } on Object {
      _isUploadRequested = false;
      _isDownloadRequested = false;
    } finally {
      _isTransferring = false;
    }
  }

  Future<bool> _uploadPending(OfflineSyncDatabaseSession session) async {
    final vocabularies = await LocalVocabulary.db.find(session, where: _isPendingUpload);
    if (vocabularies.isEmpty) return true;
    return _tracked(() => _upload(vocabularies));
  }

  Future<bool> _upload(List<LocalVocabulary> vocabularies) async {
    final notLocalIds = await _imageFileDataSource.findMissingImageIds(
      [for (final vocabulary in vocabularies) ?vocabulary.customImageId],
      LocalImageVariant.full,
    );
    var isComplete = true;
    for (final vocabulary in vocabularies) {
      final imageId = vocabulary.customImageId;
      if (imageId == null || notLocalIds.contains(imageId)) continue;
      final isUploaded =
          await _uploadVariant(imageId, LocalImageVariant.thumbnail) &&
          await _uploadVariant(imageId, LocalImageVariant.full);
      if (!isUploaded) {
        isComplete = false;
        continue;
      }
      await LocalVocabulary.db.updateRow(
        _sessions.requireWritableSession(),
        vocabulary.copyWith(customImageUploadedAt: DateTime.now().toUtc()),
        columns: (t) => [t.customImageUploadedAt],
      );
    }
    return isComplete;
  }

  Future<bool> _uploadVariant(String imageId, LocalImageVariant variant) async {
    final bytes = await _imageFileDataSource.readImage(imageId, variant);
    if (bytes == null) return false;
    return _imageTransferDataSource.upload(imageId, variant, bytes);
  }

  Future<void> _downloadMissing(OfflineSyncDatabaseSession session) async {
    final vocabularies = await LocalVocabulary.db.find(session, where: _isUploaded);
    final imageIds = [for (final vocabulary in vocabularies) ?vocabulary.customImageId];
    for (final variant in [LocalImageVariant.thumbnail, LocalImageVariant.full]) {
      final missingIds = await _imageFileDataSource.findMissingImageIds(imageIds, variant);
      await _download(session, missingIds, variant);
    }
  }

  Future<void> _download(
    OfflineSyncDatabaseSession session,
    Set<String> imageIds,
    LocalImageVariant variant,
  ) async {
    if (imageIds.isEmpty) return;
    await _tracked(() => _downloadAll(session, imageIds, variant));
  }

  Future<void> _downloadAll(
    OfflineSyncDatabaseSession session,
    Set<String> imageIds,
    LocalImageVariant variant,
  ) async {
    var remainingIds = imageIds;
    while (remainingIds.isNotEmpty && identical(_session, session)) {
      final downloads = await _imageTransferDataSource.createDownloads(
        remainingIds.toList(),
        variant,
      );
      final failedIds = <String>{};
      for (final download in downloads) {
        if (failedIds.isNotEmpty || !identical(_session, session)) {
          failedIds.add(download.imageId);
          continue;
        }
        try {
          final bytes = await _imageTransferDataSource.download(download.url);
          await _imageFileDataSource.writeImage(download.imageId, variant, bytes);
        } on DioException {
          failedIds.add(download.imageId);
        }
      }
      if (failedIds.length == downloads.length) return;
      remainingIds = failedIds;
    }
  }

  Future<T> _tracked<T>(Future<T> Function() transfer) async {
    _changeActiveTransfers(1);
    try {
      return await transfer();
    } finally {
      _changeActiveTransfers(-1);
    }
  }

  void _changeActiveTransfers(int change) {
    final wasTransferring = _activeTransfers > 0;
    _activeTransfers += change;
    final isTransferring = _activeTransfers > 0;
    if (isTransferring != wasTransferring) _transferringChanges.add(isTransferring);
  }

  Expression<dynamic> _isPendingUpload(LocalVocabularyTable t) =>
      t.customImageId.notEquals(null) & t.customImageUploadedAt.equals(null);

  Expression<dynamic> _isUploaded(LocalVocabularyTable t) =>
      t.customImageId.notEquals(null) & t.customImageUploadedAt.notEquals(null);
}
