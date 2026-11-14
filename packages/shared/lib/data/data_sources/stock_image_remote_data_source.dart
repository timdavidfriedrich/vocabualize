import 'package:vocabualize_client/vocabualize_client.dart';

abstract class StockImageRemoteDataSource {
  Future<List<RemoteStockImage>> search({
    required String query,
    required String language,
  });
}
