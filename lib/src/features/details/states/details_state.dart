import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';

class DetailsState {
  final Vocabulary vocabulary;
  final List<StockImage> stockImages;
  final bool areImagesEnabled;
  final int firstStockImageIndex;
  final int lastStockImageIndex;
  final int stockImagesPerPage;
  final int totalStockImages;

  const DetailsState({
    required this.vocabulary,
    required this.stockImages,
    required this.areImagesEnabled,
    this.firstStockImageIndex = 0,
    this.lastStockImageIndex = 6,
  })  : stockImagesPerPage = 7,
        totalStockImages = 70;

  DetailsState copyWith({
    Vocabulary? vocabulary,
    List<StockImage>? stockImages,
    bool? areImagesEnabled,
    int? firstStockImageIndex,
    int? lastStockImageIndex,
  }) {
    return DetailsState(
      vocabulary: vocabulary ?? this.vocabulary,
      stockImages: stockImages ?? this.stockImages,
      areImagesEnabled: areImagesEnabled ?? this.areImagesEnabled,
      firstStockImageIndex: firstStockImageIndex ?? this.firstStockImageIndex,
      lastStockImageIndex: lastStockImageIndex ?? this.lastStockImageIndex,
    );
  }
}
