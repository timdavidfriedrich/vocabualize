import 'package:serverpod/serverpod.dart';

import '../composition.dart';
import '../domain/caller.dart';
import '../domain/languages.dart';
import '../domain/stock_image_service.dart';
import '../generated/protocol.dart';

const _invalidRequest = "invalidRequest";

final _stockImages = StockImageService(const Composition().stockImageProvider);

class StockImageEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<List<RemoteStockImage>> search(
    Session session,
    String query,
    String language,
    RemoteInstallKey? installKey,
  ) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty || !supportedLanguages.containsKey(language)) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    return _stockImages.search(
      session,
      await const CallerResolver().resolve(session, installKey),
      query: trimmed,
      language: language,
    );
  }
}
