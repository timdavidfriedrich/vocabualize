import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';

class GetDraftImageUseCase {
  final _imageRepository = sl.get<ImageRepository>();

  Future<DraftImage?> call() {
    return _imageRepository.getImageFromCameraOrFiles();
  }
}
