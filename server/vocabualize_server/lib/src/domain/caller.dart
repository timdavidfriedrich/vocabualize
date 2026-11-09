import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'install_registry.dart';
import 'tiers.dart';

const _unauthenticated = "unauthenticated";

class const Caller({
  required final UuidValue id,
  required final String tier,
  required final DateTime? createdAt,
});

class const CallerResolver() {
  Future<Caller> resolve(Session session, RemoteInstallKey? installKey) async {
    if (session.authenticated?.userIdentifier case final identifier?) {
      return _account(session, identifier);
    }
    if (installKey == null) throw ServiceUnavailableException(reason: _unauthenticated);
    final install = await const InstallRegistry().verify(session, installKey);
    return Caller(id: install.id!, tier: tierAnonymous, createdAt: install.createdAt);
  }

  Future<Caller> _account(Session session, String identifier) async {
    final UuidValue userId;
    try {
      userId = UuidValue.withValidation(identifier);
    } on FormatException {
      throw ServiceUnavailableException(reason: _unauthenticated);
    }
    final accountTier = await AccountTier.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final tier = accountTier?.tier ?? tierFree;
    final createdAt = await _createdAt(session, userId);
    if (tier == tierFree || tier == tierPremium) {
      return Caller(id: userId, tier: tier, createdAt: createdAt);
    }
    session.log(
      "Unknown tier \"$tier\" for account ${userId.uuid} in account_tier, using $tierFree",
      level: LogLevel.warning,
    );
    return Caller(id: userId, tier: tierFree, createdAt: createdAt);
  }

  Future<DateTime?> _createdAt(Session session, UuidValue userId) async {
    try {
      return (await const AuthUsers().get(session, authUserId: userId)).createdAt;
    } on AuthUserNotFoundException {
      return null;
    }
  }
}
