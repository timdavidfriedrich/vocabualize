import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';

class UploadImageUseCase {
  final _imageRepository = sl.get<ImageRepository>();

  Future<bool> call(VocabularyImage image) {
    return _imageRepository.uploadImage(image);
  }
}
