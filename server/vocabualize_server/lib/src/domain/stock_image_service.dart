import 'package:serverpod/serverpod.dart';

import '../adapters/stock_images/stock_image_provider.dart';
import '../generated/protocol.dart';
import 'caller.dart';
import 'config_source.dart';
import 'metered_call.dart';
import 'usage_quota.dart';

const _invalidRequest = "invalidRequest";

class const StockImageService(
  final StockImageProvider Function() _provider,
) {
  Future<List<RemoteStockImage>> search(
    Session session,
    Caller caller, {
    required String query,
    required String language,
  }) {
    final config = const ConfigSource().read().stockImages;
    if (query.length > config.maxQueryLength) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    return const MeteredCall().run(
      session,
      caller,
      kind: UsageKind.stockImageSearch,
      isEnabled: config.enabled,
      perDay: config.perDay,
      request: (_) => _provider().search(query: query, language: language),
    );
  }
}
