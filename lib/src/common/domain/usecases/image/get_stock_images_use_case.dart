import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';

class GetStockImagesUseCase {
  final _stockImageRepository = sl.get<ImageRepository>();

  Future<List<StockImage>> call(String search) {
    return _stockImageRepository.getStockImages(search);
  }
}
