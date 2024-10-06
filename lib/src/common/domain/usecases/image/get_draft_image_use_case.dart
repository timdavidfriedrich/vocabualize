import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/image_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/repositories/image_repository.dart';

final getDraftImageUseCaseProvider = AutoDisposeFutureProvider((ref) {
  return GetDraftImageUseCase(
    imageRepository: ref.watch(imageRepositoryProvider),
  ).call();
});

class GetDraftImageUseCase {
  final ImageRepository _imageRepository;

  const GetDraftImageUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  Future<DraftImage?> call() {
    return _imageRepository.getImageFromCameraOrFiles();
  }
}
