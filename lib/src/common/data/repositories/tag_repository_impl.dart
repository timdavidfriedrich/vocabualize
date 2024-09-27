import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/repositories/tag_repository.dart';

final tagRepositoryProvider = Provider((ref) {
  return TagRepositoryImpl(
    remoteDatabaseDataSource: ref.watch(remoteDatabaseDataSourceProvider),
  );
});

class TagRepositoryImpl implements TagRepository {
  final RemoteDatabaseDataSource _remoteDatabaseDataSource;

  const TagRepositoryImpl({
    required RemoteDatabaseDataSource remoteDatabaseDataSource,
  }) : _remoteDatabaseDataSource = remoteDatabaseDataSource;

  @override
  Future<Tag> createTag(Tag tag) {
    // TODO: implement createTag
    throw UnimplementedError();
  }

  @override
  Future<Tag> deleteTag(Tag tag) {
    // TODO: implement deleteTag
    throw UnimplementedError();
  }

  @override
  Future<Tag> getTagById(String id) {
    // TODO: implement getTag
    throw UnimplementedError();
  }

  @override
  Future<List<Tag>> getAllTags() {
    // TODO: implement getTags
    return Future.value([]);
  }

  @override
  Future<Tag> updateTag(Tag tag) {
    // TODO: implement updateTag
    throw UnimplementedError();
  }
}
