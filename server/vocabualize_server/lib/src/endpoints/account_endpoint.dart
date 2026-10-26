import 'package:serverpod/serverpod.dart';

import '../domain/account_deletion.dart';

class AccountEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> delete(Session session) {
    return const AccountDeletion().delete(
      session,
      UuidValue.withValidation(session.authenticated!.userIdentifier),
    );
  }
}
