import '../../generated/protocol.dart';
import 'stock_image_provider.dart';

class const EchoStockImageProvider() implements StockImageProvider {
  @override
  Future<List<RemoteStockImage>> search({
    required String query,
    required String language,
  }) async => const [];
}
