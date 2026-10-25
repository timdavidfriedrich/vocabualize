import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_processing_data_source.dart';
import 'package:shared/data/data_sources/image_transfer_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/repositories/image_repository.dart';

@Injectable(as: ImageRepository)
class const ImageRepositoryImpl(
  final ImageProcessingDataSource _processingDataSource,
  final ImageTransferDataSource _transferDataSource,
) implements ImageRepository {
  @override
  Future<AppResult<ProcessedImage>> processImage(String sourcePath) async {
    try {
      final processed = await _processingDataSource.processImage(sourcePath);
      return Success(
        ProcessedImage(
          fullBytes: processed.full,
          thumbnailBytes: processed.thumbnail,
          photographer: null,
          photographerUrl: null,
        ),
      );
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }

  @override
  Future<AppResult<ProcessedImage>> processStockImage(StockImage image) async {
    try {
      final processed = await _processingDataSource.processBytes(
        await _transferDataSource.download(image.url),
      );
      return Success(
        ProcessedImage(
          fullBytes: processed.full,
          thumbnailBytes: processed.thumbnail,
          photographer: image.photographer,
          photographerUrl: image.photographerUrl,
        ),
      );
    } on Object catch (error) {
      return Failure(error.toAiError());
    }
  }
}
