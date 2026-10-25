import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

extension RemoteStockImageMappers on RemoteStockImage {
  StockImage toStockImage() {
    return StockImage(
      id: id,
      url: url,
      thumbUrl: thumbUrl,
      photographer: photographer,
      photographerUrl: photographerUrl,
    );
  }
}
