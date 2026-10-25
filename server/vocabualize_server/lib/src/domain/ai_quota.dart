import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'owner_lock.dart';

const aiTranslation = "translation";
const aiStockSearch = "stockSearch";

const _reserved = "reserved";
const _completed = "completed";
const _failed = "failed";
const _window = Duration(days: 1);

class const AiQuota() {
  Future<int?> reserve(
    Session session,
    UuidValue ownerId, {
    required String kind,
    required int limit,
    required Duration inFlightTimeout,
  }) {
    return session.db.transaction((transaction) async {
      await lockOwner(session, ownerId, transaction);
      final now = DateTime.now().toUtc();
      await AiUsage.db.deleteWhere(
        session,
        where: (t) => t.authUserId.equals(ownerId) & (t.createdAt < now.subtract(_window)),
        transaction: transaction,
      );
      final used = await AiUsage.db.count(
        session,
        where: (t) =>
            t.authUserId.equals(ownerId) &
            t.kind.equals(kind) &
            (t.status.equals(_completed) |
                (t.status.equals(_reserved) & (t.createdAt > now.subtract(inFlightTimeout)))),
        transaction: transaction,
      );
      if (used >= limit) return null;
      final usage = await AiUsage.db.insertRow(
        session,
        AiUsage(authUserId: ownerId, kind: kind, status: _reserved, createdAt: now),
        transaction: transaction,
      );
      return usage.id;
    });
  }

  Future<void> complete(Session session, int usageId) => _setStatus(session, usageId, _completed);

  Future<void> release(Session session, int usageId) => _setStatus(session, usageId, _failed);

  Future<void> _setStatus(Session session, int usageId, String status) async {
    final usage = await AiUsage.db.findById(session, usageId);
    if (usage == null) return;
    await AiUsage.db.updateRow(
      session,
      usage.copyWith(status: status),
      columns: (t) => [t.status],
    );
  }
}
