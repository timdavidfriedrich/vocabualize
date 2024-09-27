import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/image_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';

final getStockImagesUseCaseProvider = Provider((ref) {
  return GetStockImagesUseCase(
    stockImageRepository: ref.watch(imageRepositoryProvider),
  );
});

class GetStockImagesUseCase {
  final ImageRepository _imageRepository;

  const GetStockImagesUseCase({
    required ImageRepository stockImageRepository,
  }) : _imageRepository = stockImageRepository;

  Future<List<StockImage>> call(String searchTerm) {
    return _imageRepository.getStockImages(searchTerm);
  }
}
