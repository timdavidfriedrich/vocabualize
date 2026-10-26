import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_offline_sync_server/serverpod_offline_sync_server.dart';

import '../generated/protocol.dart';
import 'image_storage.dart';
import 'owner_lock.dart';

class const AccountDeletion() {
  Future<void> delete(Session session, UuidValue userId) async {
    final images = await session.db.transaction((transaction) async {
      await lockOwner(session, userId, transaction);
      await OfflineSyncSpace.db.deleteWhere(
        session,
        where: (t) => t.uuidSpaceId.equals(userId),
        transaction: transaction,
      );
      await OfflineSyncSpaceMember.db.deleteWhere(
        session,
        where: (t) => t.userUuid.equals(userId),
        transaction: transaction,
      );
      await OfflineSyncIntegrityViolation.db.deleteWhere(
        session,
        where: (t) => t.ownerSpaceUuid.equals(userId) | t.incomingSpaceUuid.equals(userId),
        transaction: transaction,
      );
      await ServiceUsage.db.deleteWhere(
        session,
        where: (t) => t.ownerId.equals(userId),
        transaction: transaction,
      );
      await AccountTier.db.deleteWhere(
        session,
        where: (t) => t.authUserId.equals(userId),
        transaction: transaction,
      );
      final reports = await Report.db.find(
        session,
        where: (t) => t.authUserId.equals(userId),
        transaction: transaction,
      );
      await Report.db.update(
        session,
        [for (final report in reports) report.copyWith(authUserId: null)],
        transaction: transaction,
      );
      final images = await StoredImage.db.deleteWhere(
        session,
        where: (t) => t.authUserId.equals(userId),
        transaction: transaction,
      );
      await const AuthUsers().delete(session, authUserId: userId, transaction: transaction);
      return images;
    });
    await const ImageStorage().deleteFiles(session, images);
    await session.messages.authenticationRevoked(userId.uuid, RevokedAuthenticationUser());
  }
}
