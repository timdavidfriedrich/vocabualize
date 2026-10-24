import 'package:core/error/app_result.dart';
import 'package:feature_details/domain/repositories/image_picker_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/image_pick_source.dart';
import 'package:shared/domain/entities/processed_image.dart';
import 'package:shared/domain/repositories/image_repository.dart';

@injectable
class const PickImageUseCase(
  final ImagePickerRepository _imagePickerRepository,
  final ImageRepository _imageRepository,
) {
  Future<AppResult<ProcessedImage?>> call(ImagePickSource source) async {
    switch (await _imagePickerRepository.pickImage(source)) {
      case Failure(:final error):
        return Failure(error);
      case Success(data: null):
        return const Success(null);
      case Success(data: final String sourcePath):
        final processed = await _imageRepository.processImage(sourcePath);
        await _imagePickerRepository.discardImage(sourcePath);
        return processed;
    }
  }
}
