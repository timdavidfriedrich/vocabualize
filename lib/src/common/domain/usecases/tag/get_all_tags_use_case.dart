import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/tag_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/repositories/tag_repository.dart';

final getAllTagsUseCaseProvider = AutoDisposeFutureProvider((ref) {
  return GetAllTagsUseCase(
    tagRepository: ref.watch(tagRepositoryProvider),
  ).call();
});

class GetAllTagsUseCase {
  final TagRepository _tagRepository;

  const GetAllTagsUseCase({
    required TagRepository tagRepository,
  }) : _tagRepository = tagRepository;

  Future<List<Tag>> call() {
    return _tagRepository.getAllTags();
  }
}
