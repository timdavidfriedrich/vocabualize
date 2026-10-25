import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/image_file_data_source.dart';
import 'package:shared/data/data_sources/tag_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/tag_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/domain/entities/collection_preview.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/repositories/tag_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _previewSize = 4;

@Injectable(as: TagRepository)
class const TagRepositoryImpl(
  final TagLocalDataSource _tagDataSource,
  final ImageFileDataSource _imageFileDataSource,
) implements TagRepository {
  @override
  Stream<AppResult<List<Tag>>> watchTags() {
    return _tagDataSource
        .watchTags()
        .map((tags) => [for (final tag in tags) tag.toTag()])
        .toAppResult();
  }

  @override
  Stream<AppResult<Tag?>> watchTag(String id) {
    return _tagDataSource
        .watchTag(UuidValue.withValidation(id))
        .map((tag) => tag?.toTag())
        .toAppResult();
  }

  @override
  Stream<AppResult<List<CollectionPreview>>> watchCollectionPreviews() {
    return _tagDataSource
        .watchCollections(previewSize: _previewSize)
        .switchMap(
          (collections) => _imageFileDataSource.watchChanges().asyncMap((_) async {
            final imagePaths = await _imageFileDataSource.findImagePaths([
              for (final collection in collections)
                for (final vocabulary in collection.newest) ?vocabulary.customImageId,
            ]);
            return [
              for (final collection in collections)
                CollectionPreview(
                  tag: collection.tag.toTag(),
                  images: [
                    for (final vocabulary in collection.newest)
                      vocabulary.toVocabulary(imagePaths: imagePaths, tagIds: const {}).image,
                  ],
                ),
            ];
          }),
        )
        .toAppResult();
  }

  @override
  Future<AppResult<Tag>> createTag(String name) async {
    try {
      final tag = await _tagDataSource.insertTag(
        LocalTag(id: const Uuid().v7obj(), name: name, createdAt: DateTime.now().toUtc()),
      );
      return Success(tag.toTag());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> renameTag(Tag tag, {required String name}) async {
    try {
      await _tagDataSource.renameTag(
        LocalTag(id: UuidValue.withValidation(tag.id), name: name, createdAt: tag.createdAt),
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> deleteTag(String id) async {
    try {
      await _tagDataSource.deleteTag(UuidValue.withValidation(id));
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }
}
