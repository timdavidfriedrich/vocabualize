import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/data_sources/remote_database_data_source.dart';
import 'package:vocabualize/src/common/data/mappers/tag_mappers.dart';
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
  Future<Tag> getTagById(String id) async {
    return await _remoteDatabaseDataSource.getTagById(id).then((value) {
      return value.toTag();
    });
  }

  @override
  Future<List<Tag>> getAllTags() async {
    return await _remoteDatabaseDataSource.getTags().then((value) {
      return value.map((e) => e.toTag()).toList();
    });
  }

  @override
  Future<String> createTag(Tag tag) async {
    return await _remoteDatabaseDataSource.createTag(tag.toRdbTag());
  }

  @override
  Future<void> deleteTag(Tag tag) async {
    await _remoteDatabaseDataSource.deleteTag(tag.toRdbTag());
  }

  @override
  Future<String> updateTag(Tag tag) async {
    return await _remoteDatabaseDataSource.updateTag(tag.toRdbTag());
  }
}
