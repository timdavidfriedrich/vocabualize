import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'owner_lock.dart';

const _reserved = "reserved";
const _completed = "completed";
const _failed = "failed";
const _lockKeyPrefix = "vocabualize:usage:";
const _day = Duration(days: 1);

enum UsageKind { translation, stockImageSearch, imageLabeling }

enum UsagePeriod { day, month }

class const UsageLimit({
  required final UsagePeriod period,
  required final int limit,
});

sealed class UsageReservation {
  const UsageReservation();
}

class const UsageReserved({
  required final int usageId,
}) extends UsageReservation;

class const UsageLimitReached({
  required final UsageLimit limit,
}) extends UsageReservation;

class const UsageExhausted() extends UsageReservation;

class const UsageQuota() {
  Future<UsageReservation> reserve(
    Session session,
    UuidValue ownerId, {
    required UsageKind kind,
    required List<UsageLimit> limits,
    required int perDay,
    required Duration inFlightTimeout,
  }) {
    return session.db.transaction((transaction) async {
      await lockKey(session, "$_lockKeyPrefix${kind.name}", transaction);
      final now = DateTime.now().toUtc();
      final inFlightSince = now.subtract(inFlightTimeout);
      await ServiceUsage.db.deleteWhere(
        session,
        where: (t) => t.kind.equals(kind.name) & (t.createdAt < _retainedSince(now)),
        transaction: transaction,
      );
      for (final limit in limits) {
        final used = await _countActive(
          session,
          transaction,
          kind: kind,
          ownerId: ownerId,
          since: limit.period.startAt(now),
          inFlightSince: inFlightSince,
        );
        if (used >= limit.limit) return UsageLimitReached(limit: limit);
      }
      final usedByEveryone = await _countActive(
        session,
        transaction,
        kind: kind,
        ownerId: null,
        since: UsagePeriod.day.startAt(now),
        inFlightSince: inFlightSince,
      );
      if (usedByEveryone >= perDay) return const UsageExhausted();
      final usage = await ServiceUsage.db.insertRow(
        session,
        ServiceUsage(ownerId: ownerId, kind: kind.name, status: _reserved, createdAt: now),
        transaction: transaction,
      );
      return UsageReserved(usageId: usage.id!);
    });
  }

  Future<int> deleteExpired(Session session) async {
    final deleted = await ServiceUsage.db.deleteWhere(
      session,
      where: (t) => t.createdAt < _retainedSince(DateTime.now().toUtc()),
    );
    return deleted.length;
  }

  Future<void> complete(Session session, int usageId) => _setStatus(session, usageId, _completed);

  Future<void> release(Session session, int usageId) => _setStatus(session, usageId, _failed);

  Future<int> _countActive(
    Session session,
    Transaction transaction, {
    required UsageKind kind,
    required UuidValue? ownerId,
    required DateTime since,
    required DateTime inFlightSince,
  }) {
    return ServiceUsage.db.count(
      session,
      where: (t) {
        final active =
            t.kind.equals(kind.name) &
            (t.createdAt >= since) &
            (t.status.equals(_completed) |
                (t.status.equals(_reserved) & (t.createdAt > inFlightSince)));
        return ownerId == null ? active : active & t.ownerId.equals(ownerId);
      },
      transaction: transaction,
    );
  }

  Future<void> _setStatus(Session session, int usageId, String status) async {
    final usage = await ServiceUsage.db.findById(session, usageId);
    if (usage == null) return;
    await ServiceUsage.db.updateRow(
      session,
      usage.copyWith(status: status),
      columns: (t) => [t.status],
    );
  }

  DateTime _retainedSince(DateTime now) => UsagePeriod.values
      .map((period) => period.startAt(now))
      .reduce((earliest, start) => start.isBefore(earliest) ? start : earliest);
}

extension UsagePeriodExtensions on UsagePeriod {
  DateTime startAt(DateTime now) => switch (this) {
    UsagePeriod.day => now.subtract(_day),
    UsagePeriod.month => DateTime.utc(now.year, now.month),
  };
}
