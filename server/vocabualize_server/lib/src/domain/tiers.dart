import '../generated/protocol.dart';
import 'usage_quota.dart';

const tierAnonymous = "anonymous";
const tierFree = "free";
const tierPremium = "premium";

const _tierOrder = [tierAnonymous, tierFree, tierPremium];

extension TiersConfigExtensions on TiersConfig {
  List<UsageLimit> limitsFor(String tier, UsageKind kind) => _of(tier).limitsFor(kind);

  String? upgradeFor(String tier, UsageKind kind, UsagePeriod period) {
    final current = _limitOf(tier, kind, period);
    for (final next in _tierOrder.skip(_tierOrder.indexOf(tier) + 1)) {
      if (_limitOf(next, kind, period) > current) return next;
    }
    return null;
  }

  int _limitOf(String tier, UsageKind kind, UsagePeriod period) =>
      limitsFor(tier, kind).where((limit) => limit.period == period).firstOrNull?.limit ?? 0;

  TierConfig _of(String tier) => switch (tier) {
    tierAnonymous => anonymous,
    tierPremium => premium,
    _ => free,
  };
}

extension TierConfigExtensions on TierConfig {
  List<UsageLimit> limitsFor(UsageKind kind) => switch (kind) {
    UsageKind.translation => [
      UsageLimit(period: UsagePeriod.day, limit: translationsPerDay),
    ],
    UsageKind.stockImageSearch => [
      UsageLimit(period: UsagePeriod.day, limit: stockImageSearchesPerDay),
    ],
    UsageKind.imageLabeling => [
      UsageLimit(period: UsagePeriod.day, limit: imageLabelingsPerDay),
      UsageLimit(period: UsagePeriod.month, limit: imageLabelingsPerMonth),
    ],
  };
}
