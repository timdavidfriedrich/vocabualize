import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vocabualize/src/features/details/data/repositories/image_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/features/details/domain/repositories/image_repository.dart';

final getDraftImageUseCaseProvider = AutoDisposeFutureProvider((ref) {
  return GetDraftImageUseCase(
    imageRepository: ref.watch(imageRepositoryProvider),
  );
});

class GetDraftImageUseCase {
  final ImageRepository _imageRepository;

  const GetDraftImageUseCase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  Future<DraftImage?> call({required ImageSource imageSource}) {
    return _imageRepository.getImageFromCameraOrFiles(imageSource: imageSource);
  }
}
