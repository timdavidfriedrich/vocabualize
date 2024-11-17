import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vocabualize/src/features/details/data/data_sources/draft_image_data_source.dart';
import 'package:vocabualize/src/features/details/data/data_sources/stock_image_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/vocabulary_image_mappers.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/features/details/domain/repositories/image_repository.dart';

final imageRepositoryProvider = Provider((ref) {
  return ImageRepositoryImpl(
    draftImageDataSource: ref.watch(draftImageDataSourceProvider),
    stockImageDataSource: ref.watch(stockImageDataSourceProvider),
  );
});

class ImageRepositoryImpl implements ImageRepository {
  final DraftImageDataSource _draftImageDataSource;
  final StockImageDataSource _stockImageDataSource;

  const ImageRepositoryImpl({
    required DraftImageDataSource draftImageDataSource,
    required StockImageDataSource stockImageDataSource,
  })  : _draftImageDataSource = draftImageDataSource,
        _stockImageDataSource = stockImageDataSource;

  @override
  Future<List<StockImage>> getStockImages(String search) {
    return _stockImageDataSource.getImages(search).then((images) {
      return images.map((image) => image.toStockImage()).toList();
    });
  }

  @override
  Future<DraftImage?> getImageFromCameraOrFiles({required ImageSource imageSource}) {
    return _draftImageDataSource.getImageFromCameraOrFiles(imageSource: imageSource).then((image) {
      return image?.toDraftImage();
    });
  }
}
