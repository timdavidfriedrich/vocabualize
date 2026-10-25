import '../../generated/protocol.dart';

abstract class StockImageProvider {
  Future<List<RemoteStockImage>> search({
    required String query,
    required String language,
  });
}

class const StockImageFailure(
  final String reason,
) implements Exception {
  @override
  String toString() => "StockImageFailure: $reason";
}
