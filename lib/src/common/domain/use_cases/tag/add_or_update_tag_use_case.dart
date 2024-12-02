import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/tag_repository_impl.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/repositories/tag_repository.dart';

final addOrUpdateTagProvider = AutoDisposeFutureProvider((ref) {
  return AddOrUpdateTagUseCase(
    tagRepository: ref.watch(tagRepositoryProvider),
  );
});

class AddOrUpdateTagUseCase {
  final TagRepository _tagRepository;

  const AddOrUpdateTagUseCase({
    required TagRepository tagRepository,
  }) : _tagRepository = tagRepository;

  Future<String> call(Tag tag) {
    return switch (tag.id == null) {
      true => _tagRepository.createTag(tag),
      false => _tagRepository.updateTag(tag),
    };
  }
}
