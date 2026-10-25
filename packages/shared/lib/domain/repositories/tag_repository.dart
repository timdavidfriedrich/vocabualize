import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/tag.dart';

abstract class TagRepository {
  Stream<AppResult<List<Tag>>> watchTags();

  Stream<AppResult<Tag?>> watchTag(String id);

  Stream<AppResult<List<CollectionPreview>>> watchCollectionPreviews();

  Future<AppResult<Tag>> createTag(String name);

  Future<AppResult<()>> renameTag(Tag tag, {required String name});

  Future<AppResult<()>> deleteTag(String id);
}
