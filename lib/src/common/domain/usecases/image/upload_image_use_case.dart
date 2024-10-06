import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/image_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';

final uploadImageUseCaseProvider = AutoDisposeProvider.family((ref, VocabularyImage image) {
  return UploadImageUseCase(
    imageRepository: ref.watch(imageRepositoryProvider),
  ).call(image);
});

class UploadImageUseCase {
  final ImageRepository _imageRepository;

  const UploadImageUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  Future<bool> call(VocabularyImage image) {
    return _imageRepository.uploadImage(image);
  }
}
