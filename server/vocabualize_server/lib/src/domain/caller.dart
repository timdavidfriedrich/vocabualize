import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'install_registry.dart';
import 'tiers.dart';

const _unauthenticated = "unauthenticated";

class const Caller({
  required final UuidValue id,
  required final String tier,
});

class const CallerResolver() {
  Future<Caller> resolve(Session session, RemoteInstallKey? installKey) async {
    if (session.authenticated?.userIdentifier case final identifier?) {
      return _account(session, identifier);
    }
    if (installKey == null) throw ServiceUnavailableException(reason: _unauthenticated);
    return Caller(
      id: await const InstallRegistry().verify(session, installKey),
      tier: tierAnonymous,
    );
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
    if (tier == tierFree || tier == tierPremium) return Caller(id: userId, tier: tier);
    session.log(
      "Unknown tier \"$tier\" for account ${userId.uuid} in account_tier, using $tierFree",
      level: LogLevel.warning,
    );
    return Caller(id: userId, tier: tierFree);
  }
}
