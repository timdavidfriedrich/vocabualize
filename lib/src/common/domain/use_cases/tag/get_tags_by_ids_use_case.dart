import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/tag_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/repositories/tag_repository.dart';

final getTagsByIdsUseCaseProvider = AutoDisposeFutureProviderFamily((ref, List<String> ids) {
  return GetTagsByIdsUseCase(
    tagRepository: ref.watch(tagRepositoryProvider),
  ).call(ids);
});

class GetTagsByIdsUseCase {
  final TagRepository _tagRepository;

  const GetTagsByIdsUseCase({
    required TagRepository tagRepository,
  }) : _tagRepository = tagRepository;

  Future<List<Tag>> call(List<String> ids) {
    return _tagRepository.getAllTags().then((tags) {
      return tags.where((tag) => ids.contains(tag.id)).toList();
    });
  }
}
