import 'package:vocabualize/src/common/domain/entities/tag.dart';

abstract interface class TagRepository {
  Future<List<Tag>> getAllTags();
  Future<Tag> getTagById(String id);
  Future<void> createTag(Tag tag);
  Future<void> updateTag(Tag tag);
  Future<void> deleteTag(Tag tag);
}
