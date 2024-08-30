import 'package:vocabualize/src/common/domain/entities/tag.dart';

abstract interface class TagRepository {
  Future<List<Tag>> getAllTags();
  Future<Tag> getTagById(String id);
  Future<Tag> createTag(Tag tag);
  Future<Tag> updateTag(Tag tag);
  Future<Tag> deleteTag(Tag tag);
}
