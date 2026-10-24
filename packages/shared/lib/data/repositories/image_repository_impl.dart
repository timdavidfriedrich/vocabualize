import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_processing_data_source.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/repositories/image_repository.dart';

@Injectable(as: ImageRepository)
class const ImageRepositoryImpl(
  final ImageProcessingDataSource _processingDataSource,
) implements ImageRepository {
  @override
  Future<AppResult<ProcessedImage>> processImage(String sourcePath) async {
    try {
      final processed = await _processingDataSource.processImage(sourcePath);
      return Success(
        ProcessedImage(fullBytes: processed.full, thumbnailBytes: processed.thumbnail),
      );
    } on Object catch (error) {
      return Failure(UnexpectedError(error.toString()));
    }
  }
}
