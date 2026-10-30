import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'caller.dart';
import 'config_source.dart';
import 'tiers.dart';
import 'usage_quota.dart';

const _disabled = "disabled";
const _exhausted = "exhausted";
const _providerFailed = "providerFailed";
// * the app's Serverpod client gives up on a call after 20 s, so a provider call can never usefully run longer, and a reservation older than this can't still be in flight
const _providerTimeout = Duration(seconds: 20);

class const MeteredCall() {
  Future<T> run<T>(
    Session session,
    Caller caller, {
    required UsageKind kind,
    required bool isEnabled,
    required int perDay,
    required Future<T> Function(int grantedUnits) request,
    int units = 1,
  }) async {
    if (!isEnabled) throw ServiceUnavailableException(reason: _disabled);
    final tiers = const ConfigSource().read().tiers;
    final reservation = await const UsageQuota().reserve(
      session,
      caller.id,
      kind: kind,
      limits: tiers.limitsFor(caller.tier, kind),
      perDay: perDay,
      units: units,
      inFlightTimeout: _providerTimeout,
    );
    final usageIds = switch (reservation) {
      UsageReserved(:final usageIds) => usageIds,
      UsageLimitReached(:final limit) => throw QuotaExceededException(
        kind: kind.name,
        period: limit.period.name,
        limit: limit.limit,
        upgradeTier: tiers.upgradeFor(caller.tier, kind, limit.period),
      ),
      UsageExhausted() => throw ServiceUnavailableException(reason: _exhausted),
    };
    final T result;
    try {
      result = await request(usageIds.length).timeout(_providerTimeout);
    } on Object catch (error) {
      await const UsageQuota().release(session, usageIds);
      session.log("${kind.name} failed: $error", level: LogLevel.warning);
      throw ServiceUnavailableException(reason: _providerFailed);
    }
    await const UsageQuota().complete(session, usageIds);
    return result;
  }
}
