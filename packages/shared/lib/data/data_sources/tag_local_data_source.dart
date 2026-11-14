import 'package:vocabualize_client/vocabualize_client.dart';

abstract class TagLocalDataSource {
  Stream<List<LocalTag>> watchTags();

  Stream<LocalTag?> watchTag(UuidValue id);

  Stream<List<({LocalTag tag, List<LocalVocabulary> newest})>> watchCollections({
    required int previewSize,
  });

  Future<LocalTag> insertTag(LocalTag tag);

  Future<void> updateTag(LocalTag tag);

  Future<void> deleteTag(UuidValue id);
}
