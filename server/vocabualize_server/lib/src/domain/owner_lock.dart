import 'package:serverpod/serverpod.dart';

Future<void> lockOwner(Session session, UuidValue ownerId, Transaction transaction) async {
  await session.db.unsafeQuery(
    "SELECT pg_advisory_xact_lock(hashtext(@owner))",
    parameters: QueryParameters.named({"owner": ownerId.uuid}),
    transaction: transaction,
  );
}
