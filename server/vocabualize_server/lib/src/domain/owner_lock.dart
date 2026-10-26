import 'package:serverpod/serverpod.dart';

Future<void> lockOwner(Session session, UuidValue ownerId, Transaction transaction) {
  return lockKey(session, ownerId.uuid, transaction);
}

Future<void> lockKey(Session session, String key, Transaction transaction) async {
  await session.db.unsafeQuery(
    "SELECT pg_advisory_xact_lock(hashtext(@key))",
    parameters: QueryParameters.named({"key": key}),
    transaction: transaction,
  );
}
