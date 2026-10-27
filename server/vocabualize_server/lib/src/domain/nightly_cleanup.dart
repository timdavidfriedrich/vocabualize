import 'package:serverpod/serverpod.dart';
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart';

import '../generated/protocol.dart';
import 'image_storage.dart';
import 'usage_quota.dart';

const _orphanedPhotoGracePeriod = Duration(days: 30);
// * an install's only server data is its quota counters, and the longest quota window is one calendar month
const _unusedInstallPeriod = Duration(days: 31);
const _reportRetention = Duration(days: 365);

class const NightlyCleanup() {
  Future<void> run(Session session) async {
    final now = DateTime.now().toUtc();
    final photos = await _deleteOrphanedPhotos(
      session,
      uploadedBefore: now.subtract(_orphanedPhotoGracePeriod),
    );
    final installs = await _deleteUnusedInstalls(
      session,
      lastUsedBefore: now.subtract(_unusedInstallPeriod),
    );
    final usages = await const UsageQuota().deleteExpired(session);
    final reports = await Report.db.deleteWhere(
      session,
      where: (t) => t.createdAt < now.subtract(_reportRetention),
    );
    session.log(
      "Nightly cleanup deleted ${photos.length} orphaned photo files "
      "(${photos.fold(0, (bytes, image) => bytes + image.byteSize)} bytes), "
      "$installs unused installs, $usages expired usage rows and ${reports.length} old reports",
    );
  }

  Future<List<StoredImage>> _deleteOrphanedPhotos(
    Session session, {
    required DateTime uploadedBefore,
  }) async {
    final candidates = await StoredImage.db.find(
      session,
      where: (t) => t.uploadedAt < uploadedBefore,
    );
    final candidatesByOwner = <UuidValue, List<StoredImage>>{};
    for (final image in candidates) {
      candidatesByOwner.putIfAbsent(image.authUserId, () => []).add(image);
    }
    final deleted = <StoredImage>[];
    for (final MapEntry(key: ownerId, value: images) in candidatesByOwner.entries) {
      final referenced = await _referencedImageIds(session, ownerId, images);
      for (final image in images) {
        if (referenced.contains(image.imageId.uuid)) continue;
        if (!await const ImageStorage().deleteFile(session, image)) continue;
        await StoredImage.db.deleteRow(session, image);
        deleted.add(image);
      }
    }
    return deleted;
  }

  Future<Set<String>> _referencedImageIds(
    Session session,
    UuidValue ownerId,
    List<StoredImage> images,
  ) async {
    final space = await OfflineSyncSpace.db.findFirstRow(
      session,
      where: (t) => t.uuidSpaceId.equals(ownerId),
    );
    final spaceId = space?.id;
    if (spaceId == null) return const {};
    final vocabularies = await LocalVocabulary.db.find(
      session,
      where: (t) =>
          t.spaceId.equals(spaceId) &
          t.customImageId.inSet({for (final image in images) image.imageId.uuid}),
    );
    return {for (final vocabulary in vocabularies) ?vocabulary.customImageId};
  }

  Future<int> _deleteUnusedInstalls(Session session, {required DateTime lastUsedBefore}) async {
    return session.db.transaction((transaction) async {
      final installs = await Install.db.deleteWhere(
        session,
        where: (t) => t.lastUsedAt < lastUsedBefore,
        transaction: transaction,
      );
      final installIds = {for (final install in installs) ?install.id};
      if (installIds.isNotEmpty) {
        await ServiceUsage.db.deleteWhere(
          session,
          where: (t) => t.ownerId.inSet(installIds),
          transaction: transaction,
        );
      }
      return installs.length;
    });
  }
}
