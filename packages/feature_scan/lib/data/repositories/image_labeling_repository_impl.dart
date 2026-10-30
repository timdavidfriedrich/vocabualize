import 'package:core/error/app_result.dart';
import 'package:feature_scan/data/data_sources/image_labeling_remote_data_source.dart';
import 'package:feature_scan/data/mappers/image_label_mappers.dart';
import 'package:feature_scan/domain/repositories/image_labeling_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_processing_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/domain/entities/image_label.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/processed_image.dart';

const _labelingLongEdge = 512;

@Injectable(as: ImageLabelingRepository)
class const ImageLabelingRepositoryImpl(
  final ImageProcessingDataSource _processingDataSource,
  final ImageLabelingRemoteDataSource _remoteDataSource,
) implements ImageLabelingRepository {
  @override
  Future<AppResult<List<ImageLabel>>> labelImage({
    required ProcessedImage photo,
    required Language language,
  }) async {
    try {
      final image = await _processingDataSource.createLabelingImage(
        photo.fullBytes,
        longEdge: _labelingLongEdge,
      );
      final labels = await _remoteDataSource.label(
        image: image,
        language: language.toLanguageCode(),
      );
      return Success([for (final label in labels) label.toImageLabel()]);
    } on Object catch (error) {
      return Failure(error.toServiceError());
    }
  }
}
