import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/service_access_data_source.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

abstract class StockImageRemoteDataSource {
  Future<List<RemoteStockImage>> search({
    required String query,
    required String language,
  });
}

@Injectable(as: StockImageRemoteDataSource)
class const StockImageRemoteDataSourceImpl(
  final Client _client,
  final ServiceAccessDataSource _serviceAccess,
) implements StockImageRemoteDataSource {
  @override
  Future<List<RemoteStockImage>> search({
    required String query,
    required String language,
  }) => _serviceAccess.run(
    (installKey) => _client.stockImage.search(query, language, installKey),
  );
}
